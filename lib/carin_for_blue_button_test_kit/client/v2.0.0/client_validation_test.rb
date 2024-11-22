module CarinForBlueButtonTestKit
  module ClientValidationTest
    def previous_claims_data_request_resources(resource_type_tag = nil)
      hash = Hash.new { |hash, key| hash[key] = [] }
      previous_claims_data_requests(resource_type_tag).each_with_object(hash) do |request, request_resource_hash|
        request_resources =
          if request.status == 200
            request.resource.entry.map(&:resource)
          else
            []
          end
        request_resource_hash[request].concat(request_resources)
      end
    end

    def extract_eob_profile(resource)
      profile_url = resource.meta.profile.find do |profile|
        profile.include?('StructureDefinition/C4BB-ExplanationOfBenefit')
      end
      match = %r{http://hl7.org/fhir/us/carin-bb/StructureDefinition/(.*)}.match(profile_url)
      return unless match.present?

      match[1].delete_prefix('C4BB-ExplanationOfBenefit-').split('|')[0].gsub('-', '_')
    end

    def previous_claims_data_request_resources_scratch(resource_type_tag)
      previous_claims_data_request_resources(resource_type_tag).each do |request, resources|
        resources.each do |resource|
          next unless resource_type_tag.to_s.include?(resource.resourceType)

          if resource.resourceType == 'ExplanationOfBenefit'
            profile = extract_eob_profile(resource)
            identifier = "#{resource.resourceType}_#{profile}"
            scratch[identifier.to_sym] ||= []
            scratch[identifier.to_sym] |= [resource]
          end
          scratch[resource.resourceType.to_sym] ||= []
          scratch[resource.resourceType.to_sym] |= [resource]
        end
      end
    end

    def previous_resource_requests(resource_type_tag)
      previous_claims_data_request_resources_scratch(resource_type_tag)
      scratch[resource_type_tag]
    end

    def previous_claims_data_search_parameters_scratch
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
      previous_claims_data_search_parameters_scratch unless scratch[:SavedSearchParams]
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

    def previous_claims_data_requests(resource_type_tag = nil)
      if resource_type_tag.present?
        load_tagged_requests(RESOURCE_API_TAG, resource_type_tag.to_s)
      else
        load_tagged_requests(RESOURCE_API_TAG)
      end
    end

    def flattened_all_resources
      @flattened_all_resources ||= previous_claims_data_request_resources.values.flatten
    end
  end
end
