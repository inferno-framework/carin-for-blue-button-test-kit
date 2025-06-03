# frozen_string_literal: true

module CarinForBlueButtonTestKit
  module ClientValidationTest
    def all_resource_types
      %w[Patient Coverage Organization Practitioner RelatedPerson
         ExplanationOfBenefit_Inpatient_Institutional ExplanationOfBenefit_Outpatient_Institutional
         ExplanationOfBenefit_Oral ExplanationOfBenefit_Pharmacy ExplanationOfBenefit_Professional_NonClinician]
    end

    def previous_claims_data_request_resources(resource_type_tag)
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
      previous_claims_data_request_resources(resource_type_tag).each_value do |resources|
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

    def previous_claims_data_search_parameters_scratch(resource_type_tag)
      previous_claims_data_request_resources(resource_type_tag).each_key do |request|
        endpoint_resource = resource_type_endpoint(request.url)
        search_params = request.tags - [RESOURCE_API_TAG, resource_type_tag.to_s] - all_resource_types

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
      previous_claims_data_search_parameters_scratch(resource_tag)
      scratch[resource_tag]
    end

    def resource_type_endpoint(url)
      return unless url.start_with?('http://', 'https://')

      match = %r{custom/#{suite_id}/fhir/(.*)\?}.match(url)
      match[1] if match.present?
    end

    def connect_bundle(export_binary)
      export_binary.split(/(?<=}\n)(?={)/).map { |str| FHIR.from_contents(str) }
    end

    def previous_claims_data_requests(resource_type_tag = nil)
      load_tagged_requests(RESOURCE_API_TAG, resource_type_tag.to_s)
    end

    def flattened_all_resources
      @flattened_all_resources ||= previous_claims_data_request_resources.values.flatten
    end
  end
end
