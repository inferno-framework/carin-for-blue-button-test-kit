require_relative 'date_search_validator'
require_relative 'fhir_resource_navigation'
require_relative 'search_test_properties'

module CARINForBlueButton
    module CarinSearchTest
        extend Forwardable
        include DateSearchValidation
        include FHIRResourceNavigation
  
        def_delegators 'self.class', :metadata, :provenance_metadata, :properties
        def_delegators 'properties',
                        :resource_type,
                        :search_param_names,
                        :saves_delayed_references?,
                        :first_search?,
                        :fixed_value_search?,
                        :possible_status_search?,
                        :test_medication_inclusion?,
                        :test_post_search?,
                        :token_search_params,
                        :test_reference_variants?,
                        :params_with_comparators,
                        :multiple_or_search_params

        def run_search_test(param_value)
            search_params = self.search_param_names.each_with_object({}) do |name, params|
                params[name] = param_value
            end

            fhir_search(resource_type, params: search_params)
            returned_resources = extract_resources_from_bundle(bundle: resource, response: response).select{|item| item.resourceType == resource_type}

            return [] if returned_resources.blank?

        end

        def extract_resources_from_bundle(
            bundle: nil,
            response: nil,
            reply_handler: nil,
            max_pages: 20,
            additional_resource_types: [],
            resource_type: self.resource_type
        )
            page_count = 1
            resources = []
            
            until bundle.nil? || page_count == max_pages
                resources += bundle&.entry&.map { |entry| entry&.resource }
                next_bundle_link = bundle&.link&.find { |link| link.relation == 'next' }&.url
                reply_handler&.call(response)

                break if next_bundle_link.blank?

                page_count += 1

                store_request('outgoing') { reply }
                error_message = "Could not resolve next bundle: #{next_bundle_link}"

                assert_response_status(200)
                assert_valid_json(reply.body, error_message)

                bundle = fhir_client.parse_reply(FHIR::Bundle, fhir_client.default_format, reply)

                page_count += 1
            end
            
            resources
        end
    end
end