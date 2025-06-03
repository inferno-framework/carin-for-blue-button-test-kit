# frozen_string_literal: true

require_relative 'user_input_response'
require_relative 'urls'
require_relative 'collection'
require_relative 'client_validation_test'

module CarinForBlueButtonTestKit
  # Serve responses to CARIN requests
  #
  # Note that there are numerous expected validation issues that can safely be ignored.
  # See here for full list: https://hl7.org/fhir/us/carin-bb/STU2/qa.html#suppressed

  module MockServer
    include URLs

    SUPPORTED_SCOPES = ['launch', 'patient/*.rs', 'user/*.rs', 'offline_access'].freeze

    def server_proxy
      @server_proxy ||= Faraday.new(
        url: ENV.fetch('FHIR_REFERENCE_SERVER'),
        params: {},
        headers: { 'Content-Type' => 'application/json', 'Authorization' => 'Bearer SAMPLE_TOKEN',
                   'Host' => ENV.fetch('HOST_HEADER') }
      ) do |proxy|
        proxy.use FaradayMiddleware::Gzip
        proxy.options.params_encoder = Faraday::FlatParamsEncoder
      end
    end

    def error_response_resource(request)
      server_response = server_proxy.get('Patient', { _id: 888 })
      response_resource = FHIR.from_contents(server_response.body)
      response_resource.entry = [{ fullUrl: 'urn:uuid:2866af9c-137d-4458-a8a9-eeeec0ce5583',
                                   resource: mock_operation_outcome_resource, search: { mode: 'outcome' } }]
      response_resource.link.first.url = request.url # specific case for Operation Outcome handling
      response.status = 403
      response_resource
    end

    def get_params(query_string)
      params = {}
      query_string.split('&').each do |param|
        split_param = param.split('=')
        params[split_param.first] = [] if params[split_param.first].nil?
        params[split_param.first].append(split_param.last)
      end
      params
    end

    def carin_resource_response(request, _test = nil, _test_result = nil)
      endpoint = resource_endpoint(request.url)
      if endpoint
        request_parameters = get_params(request.query_string)
        params = match_request_to_expectation(endpoint, request_parameters)
        if params.present?
          server_response = server_proxy.get(endpoint, params)
          response.status = server_response.status
          response_resource = if response.status == 200
                                replace_bundle_urls(FHIR.from_contents(server_response.body))
                              else
                                FHIR.from_contents(server_response.body)
                              end
          response.headers.merge!(server_response.headers)
          remove_transfer_encoding_and_content_length_header(response.headers)
        else
          response_resource = error_response_resource(request)
        end
      else
        response_resource = error_response_resource(request)
      end
      response.body = response_resource.to_json
    end

    def carin_resource_id_response(request)
      endpoint = resource_id_endpoint(request.url)
      if endpoint
        server_response = server_proxy.get(endpoint)
        response.status = server_response.status
        response_resource = FHIR.from_contents(server_response.body)
        response.headers.merge!(server_response.headers)
        remove_transfer_encoding_and_content_length_header(response.headers)
      else
        response_resource = error_response_resource(request)
      end
      response.body = response_resource.to_json
    end

    def read_next_page(request, _test = nil, _test_result = nil)
      server_response = server_proxy.get('', JSON.parse(request.params.to_json))
      response.status = server_response.status
      response.response_headers = remove_transfer_encoding_header(server_response.headers)
      response.response_body = replace_bundle_urls(FHIR.from_contents(server_response.body)).to_json
    end

    def get_metadata
      erb_template = ERB.new(
        File.read(
          File.join(__dir__,
                    'metadata/mock_capability_statement.json.erb')
        )
      )
      capability_statement = JSON.parse(erb_template.result).to_json

      proc {
        [200, { 'Content-Type' => 'application/fhir+json;charset=utf-8' },
         [capability_statement]]
      }
    end

    def remove_transfer_encoding_and_content_length_header(headers)
      headers.delete('transfer-encoding') if headers['transfer-encoding'].present?

      return unless headers['Content-Length'].present?

      headers.delete('Content-Length')
    end

    def supported_searches
      @supported_searches ||= SEARCHES_BY_PRIORITY
    end

    def match_request_to_expectation(resource_type, params)
      matched_search = supported_searches[resource_type.to_sym].select do |expectation|
        (params.keys.map(&:to_s) & expectation).sort == expectation
      end.map(&:first)

      if matched_search.present?
        return params.select do |key, _value|
          matched_search.include?(key.to_s) || key == '_revInclude' || key == '_include'
        end
      end
      nil
    end

    def extract_client_id(request)
      URI.decode_www_form(request.body.read).to_h['client_id']
    end

    # Header expected to be a bearer token of the form "Bearer: <token>"
    def extract_bearer_token(request)
      request.headers['authorization']&.delete_prefix('Bearer ')
    end

    def extract_token_from_query_params(request)
      request.query_parameters['token']
    end

    def extract_test_run_identifier_from_query_params(request)
      request.query_parameters['test_run_identifier']
    end

    # Pull resource type from url
    # e.g. http://example.org/fhir/Patient?_id=123 -> Patient
    # @private
    def resource_endpoint(url)
      return unless url.start_with?('http://', 'https://')

      match = %r{custom/#{suite_id}/fhir/(.*)\?}.match(url)
      match[1] if match.present?
    end

    def resource_id_endpoint(url)
      return unless url.start_with?('http://', 'https://')

      match = %r{custom/#{suite_id}/fhir/(.*)}.match(url)
      match[1] if match.present?
    end

    def mock_operation_outcome_resource
      FHIR.from_contents(File.read(
                           File.join(__dir__,
                                     'metadata/mock_operation_outcome_resource.json')
                         ))
    end

    def replace_bundle_urls(bundle)
      reference_server_base = ENV.fetch('FHIR_REFERENCE_SERVER')
      bundle&.link&.map! { |link| { relation: link.relation, url: link.url.gsub(reference_server_base, new_link) } }
      bundle&.entry&.map! do |bundled_resource|
        { fullUrl: bundled_resource.fullUrl.gsub(reference_server_base, new_link),
          resource: bundled_resource.resource,
          search: bundled_resource.search }
      end
      bundle
    end

    def new_link
      "#{Inferno::Application['base_url']}/custom/#{suite_id}/fhir"
    end

    def suite_id
      C4BBV200ClientSuite.id
    end

    # @private
    def find_matching_entry(ref, entries, root_url = '')
      ref = "#{root_url}/#{ref}" if relative_reference?(ref) && root_url&.present?

      entries&.find { |entry| entry&.fullUrl == ref }
    end

    # @private
    def relative_reference?(ref)
      ref&.count('/') == 1
    end
  end
end
