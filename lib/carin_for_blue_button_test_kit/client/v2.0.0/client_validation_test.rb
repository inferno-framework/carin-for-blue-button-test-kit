module CarinForBlueButtonTestKit
  module ClientValidationTest
    def previous_claims_data_request_resources
      hash = Hash.new { |hash, key| hash[key] = [] }
      previous_claims_data_requests.each_with_object(hash) do |request, request_resource_hash|
        request_resources =
          if request.status == 200
            request.resource.entry.map(&:resource)
          else
            []
          end
        request_resource_hash[request].concat(request_resources)
      end
    end

    def previous_claims_data_search_parameters
      previous_claims_data_request_resources.each_key do |request|
        search_params = request.tags - [RESOURCE_API_TAG]
        endpoint_resource = resource_type_endpoint(request.url)
        scratch[:"#{endpoint_resource}Search"] ||= []
        search_params.each do |search_param|
          unless scratch[:"#{endpoint_resource}Search"].include?(search_param)
            scratch[:"#{endpoint_resource}Search"].append(search_param)
          end
        end
      end
      scratch[:SavedSearchParams] = true
    end

    def resource_previous_search_params(resource_tag)
      previous_claims_data_search_parameters unless scratch[:SavedSearchParams]
      scratch[resource_tag]
    end

    def resource_type_endpoint(url)
      return unless url.start_with?('http://', 'https://')

      match = %r{custom/c4bb_v200_client/fhir/(.*)\?}.match(url)
      match[1] if match.present?
    end

    def connect_bundle(export_binary)
      export_binary.split(/(?<=}\n)(?={)/).map { |str| FHIR.from_contents(str) }
    end

    def previous_claims_data_requests
      @previous_claims_data_requests ||= load_tagged_requests(RESOURCE_API_TAG)
    end

    def flattened_all_resources
      @flattened_all_resources ||= previous_claims_data_request_resources.values.flatten
    end
  end
end
