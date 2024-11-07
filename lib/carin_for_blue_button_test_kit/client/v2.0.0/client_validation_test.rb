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

    def resource_type_endpoint(url)
      return unless url.start_with?('http://', 'https://')

      match = %r{custom/c4bb_v200_client/fhir/(.*)\?}.match(url)
      match[1] if match.present?
    end

    def connect_bundle(export_binary)
      export_binary.split(/(?<=}\n)(?={)/).map { |str| FHIR.from_contents(str) }
    end

    def previous_claims_data_requests
      @previous_claims_data_requests ||= load_tagged_requests(SUBMIT_TAG)
    end

    def flattened_all_resources
      @flattened_all_resources ||= previous_claims_data_request_resources.values.flatten
    end
  end
end
