require_relative 'user_input_response'
require_relative 'urls'
require_relative 'collection'
require_relative 'client_validation_test'
# require_relative 'metadata/mock_capability_statement'

module CarinForBlueButtonTestKit
  # Serve responses to Carin requests
  #
  # Note that there are numerous expected validation issues that can safely be ignored.
  # See here for full list: https://hl7.org/fhir/us/carin-bb/STU2/qa.html#suppressed
  module MockServer
    include URLs

    def server_proxy
      @server_proxy ||= Faraday.new(
        url: ENV.fetch('FHIR_REFERENCE_SERVER'),
        params: {},
        headers: { 'Content-Type' => 'application/json', 'Authorization' => 'Bearer SAMPLE_TOKEN',
                   'Host' => ENV.fetch('HOST_HEADER') }
      ) do |proxy|
        proxy.use FaradayMiddleware::Gzip
      end
    end

    def token_response(request, _test = nil, _test_result = nil)
      # Placeholder for a more complete mock token endpoint
      request.response_body = { access_token: SecureRandom.hex, token_type: 'bearer', expires_in: 300 }.to_json
      request.status = 200
    end

    def error_response_resource(request)
      response = server_proxy.get('Patient', { _id: 998 })
      response_resource = FHIR.from_contents(response.body)
      response_resource.entry = [{ fullUrl: 'urn:uuid:2866af9c-137d-4458-a8a9-eeeec0ce5583',
                                   resource: mock_operation_outcome_resource, search: { mode: 'outcome' } }]
      response_resource.link.first.url = request.url # specific case for Operation Outcome handling
      request.status = 403
      response_resource
    end

    def carin_resource_response(request, test = nil, test_result = nil)
      endpoint = resource_endpoint(request.url)
      if endpoint
        params = match_request_to_expectation(endpoint, request.query_parameters)
        if params
          response = server_proxy.get(endpoint, params)
          request.status = response.status
          response_resource = replace_bundle_urls(FHIR.from_contents(response.body))
          request.response_headers = remove_transfer_encoding_and_content_length_header(response.headers)

        else
          response_resource = error_response_resource(request)
        end
      else
        response_resource = error_response_resource(request)
      end
      request.response_body = response_resource.to_json
    end

    def read_next_page(request, test = nil, test_result = nil)
      response = server_proxy.get('', request.query_parameters)
      request.status = response.status
      request.response_headers = remove_transfer_encoding_header(response.headers)
      request.response_body = replace_bundle_urls(FHIR.from_contents(response.body)).to_json
    end

    def get_metadata
      proc {
        [200, { 'Content-Type' => 'application/fhir+json;charset=utf-8' },
         [File.read('lib/carin_for_blue_button_test_kit/metadata/mock_capability_statement.json')]]
      }
    end

    def remove_transfer_encoding_and_content_length_header(headers)
      headers.reject! { |key, value| key == 'transfer-encoding' } if headers['transfer-encoding'].present?

      return headers unless headers['Content-Length'].present?

      headers.reject! { |key, value| key == 'Content-Length' }
    end

    def match_request_to_expectation(endpoint, params)
      matched_search = SEARCHES_BY_PRIORITY[endpoint.to_sym].find do |expectation|
        (params.keys.map(&:to_s) & expectation).sort == expectation
      end
      # matched_search_without_patient = SEARCHES_BY_PRIORITY[endpoint.to_sym].find {|expectation| (params.keys.map{|key| key.to_s} << "patient" & expectation) == expectation}

      if matched_search
        params.select { |key, value| matched_search.include?(key.to_s) || key == '_revInclude' || key == '_include' }
      else
        nil
      end
      # else
      #   new_params = params.select {|key, value| matched_search_without_patient.include?(key.to_s) || key == "_revInclude" || key == "_include"}
      #   new_params["patient"] = patient_id_from_match_request
      #   new_params
      # end
    end

    def extract_client_id(request)
      URI.decode_www_form(request.request_body).to_h['client_id']
    end

    # Header expected to be a bearer token of the form "Bearer: <token>"
    def extract_bearer_token(request)
      request.request_header('Authorization')&.value&.split&.last
    end

    def extract_token_from_query_params(request)
      request.query_parameters['token']
    end

    # Pull resource type from url
    # e.g. http://example.org/fhir/Patient?_id=123 -> Patient
    # @private
    def resource_endpoint(url)
      return unless url.start_with?('http://', 'https://')

      match = %r{custom/c4bb_client/fhir/(.*)\?}.match(url)
      match[1] if match.present?
    end

    # @private
    def referenced_entities(resource, entries, root_url)
      matches = []
      attributes = resource&.source_hash&.keys
      attributes.each do |attr|
        value = resource.send(attr.to_sym)
        if value.is_a?(FHIR::Reference) && value.reference.present?
          match = find_matching_entry(value.reference, entries, root_url)
          if match.present? && matches.none?(match)
            value.reference = match.fullUrl
            matches.concat([match], referenced_entities(match.resource, entries, root_url))
          end
        elsif value.is_a?(Array) && value.all? { |elmt| elmt.is_a?(FHIR::Model) }
          value.each { |val| matches.concat(referenced_entities(val, entries, root_url)) }
        end
      end

      matches
    end

    def mock_operation_outcome_resource
      FHIR.from_contents(File.read('lib/carin_for_blue_button_test_kit/client/metadata/mock_operation_outcome_resource.json'))
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
      "#{Inferno::Application['base_url']}/custom/c4bb_client/fhir"
    end

    # @private
    def absolute_reference(ref, entries, root_url)
      url = find_matching_entry(ref&.reference, entries, root_url)&.fullUrl
      ref.reference = url if url
      ref
    end

    def fetch_all_bundled_resources(
      reply_handler: nil,
      max_pages: 0,
      additional_resource_types: [],
      resource_type: self.resource_type
    )
      page_count = 1
      resources = []
      bundle = resource
      resources += bundle&.entry&.map { |entry| entry&.resource }

      until bundle.nil? || (page_count == max_pages && max_pages != 0)

        next_bundle_link = bundle&.link&.find { |link| link.relation == 'next' }&.url
        reply_handler&.call(response)

        break if next_bundle_link.blank?

        reply = fhir_client.raw_read_url(next_bundle_link)

        store_request('outgoing') { reply }
        error_message = cant_resolve_next_bundle_message(next_bundle_link)

        assert_response_status(200)
        assert_valid_json(reply.body, error_message)

        bundle = fhir_client.parse_reply(FHIR::Bundle, fhir_client.default_format, reply)
        resources += bundle&.entry&.map { |entry| entry&.resource }

        page_count += 1
      end
      valid_resource_types = [resource_type, 'OperationOutcome'].concat(additional_resource_types)
      resources
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
