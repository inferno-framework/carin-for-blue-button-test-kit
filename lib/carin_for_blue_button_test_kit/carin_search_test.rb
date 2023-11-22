require_relative 'date_search_validator'
require_relative 'fhir_resource_navigation'
require_relative 'search_test_properties'

module CarinForBlueButtonTestKit
  module CarinSearchTest
    extend Forwardable
    include DateSearchValidation
    include FHIRResourceNavigation

    def_delegators 'self.class', :metadata, :properties
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
                   :multiple_or_search_params,
                   :include_parameters

    def all_scratch_resources
      scratch_resources[:all] ||= []
    end

    def run_search_test(param_value, resource_id: nil)
      search_params = {}

      param_name = search_param_names[0]
      if patient_id_param?(param_name)
        returned_resources = []
        param_value.each do |id|
          search_params[param_name] = id
          returned_resources.concat(perform_search(search_params))
        end
        search_params[param_name] = param_value.join(',')
      else
        search_params[param_name] = param_value
        returned_resources = perform_search(search_params)
      end

      all_scratch_resources.concat(returned_resources).uniq! if first_search?

      perform_response_validation(returned_resources, search_params)
    end

    def perform_search(search_params)
      fhir_search(resource_type, params: search_params)

      assert_response_status(200)
      assert_resource_type(:bundle)

      extract_resources_from_bundle(bundle: resource, response:).select do |item|
        item.resourceType == resource_type
      end
    end

    def perform_response_validation(returned_resources, search_params)
      skip_if returned_resources.blank?, no_resources_message

      returned_resources.each do |resource|
        check_resource_against_params(resource, search_params)
      end
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
      end

      resources
    end

    def search_param_paths(name)
      paths = metadata.search_definitions[name.to_sym][:paths]
      paths[0] = 'local_class' if paths.first == 'class'

      paths
    end

    def no_resources_message
      'No resources were returned from this query.'
    end

    # VALIDATION

    def check_resource_against_params(resource, search_params)
      search_params.each do |name, param_value|
        paths = if name == '_id'
                  ['id']
                elsif name == '_lastUpdated'
                  ['meta.lastUpdated']
                else
                  search_param_paths(name)
                end

        match_found = false
        values_found = []

        paths.each do |path|
          type = if name == '_id'
                   'http://hl7.org/fhirpath/System.String'
                 elsif name == '_lastUpdated'
                   'date'
                 else
                   metadata.search_definitions[name.to_sym][:type]
                 end

          values_found =
            resolve_path(resource, path)
            .map do |value|
              value.try(:reference) || value
            end

          match_found = case type
                        when 'Reference'
                          values_found.any? do |val|
                            val.include? param_value
                          end
                        when 'CodeableConcept'
                          codings = values_found.flat_map do |val|
                            val.coding || nil
                          end.compact
                          if param_value.include? '|'
                            system = param_value.split('|').first
                            code = param_value.split('|').last
                            codings&.any? do |coding|
                              coding.system == system && coding.code&.casecmp?(code)
                            end
                          else
                            codings&.any? { |coding| coding.code&.casecmp?(param_value) }
                          end
                        when 'Identifier'
                          if param_value.include? '|'
                            values_found.any? do |identifier|
                              puts "#{identifier.system}|#{identifier.value}"
                              "#{identifier.system}|#{identifier.value}" == param_value
                            end
                          else
                            values_found.any? { |identifier| identifier.value == param_value }
                          end
                        when 'Period', 'date', 'instant', 'dateTime'
                          values_found.any? { |date| validate_date_search(param_value, date) }
                        when 'http://hl7.org/fhirpath/System.String'
                          values_found.any? { |str| param_value.split(',').include?(str) }
                        else
                          false
                        end

          break if match_found
        end
        assert match_found, 'Returned resource did not match the search parameter'
      end
    end

    def run_include_search(param_value, resource_id: nil)
      search_params = { _id: resource_id }
      search_params['_include'] = param_value

      fhir_search(resource_type, params: search_params)
      assert_response_status(200)
      assert_resource_type(:bundle)

      returned_resources_all = extract_resources_from_bundle(bundle: resource, response: response)
      base_resources = returned_resources_all.select{|item| item.resourceType == resource_type}

      skip_if base_resources.blank?, self.no_resources_message

      values_found = []
      base_resource_matches = []
      
      base_resources.each do |resource|
        match_found = false
        reference_bool = true

        if param_value != 'ExplanationOfBenefit:*'
          include_parameters.each do |include_param|
              values_found = resolve_path(resource, include_param[:path])
              match_found = (values_found.length > 0)
              base_resource_matches = matched_base_resources(resource, include_param[:target], returned_resources_all, values_found)

              break if match_found
          end
          assert match_found, "Returned resource did not match the search parameter"
        else
          include_parameters.each do |include_param|
              paths_found = resolve_path(resource, include_param[:path])
              values_found += paths_found
              base_resource_matches += matched_base_resources(resource, include_param[:target], returned_resources_all, values_found)
          end
          match_found = (values_found.length >= 5)
          assert match_found, "Returned resource did not match the search parameter"  
        end
  
        all_included_resource_types = include_parameters.map {|param| param[:target]}.flatten.uniq
        included_resources = returned_resources_all.select{|item| all_included_resource_types.include?(item.resourceType)}.map { |resource| "#{resource.resourceType}/#{resource.id}" }
        not_matched_included_resources = included_resources.select do |resource_reference|
          base_resource_matches.none? do |base_resource_references|
            is_reference_match?(base_resource_references.reference, resource_reference)
          end
        end
        not_matched_included_resources_string = not_matched_included_resources.join(',')
        assert not_matched_included_resources.empty?, "No #{resource_type} references #{not_matched_included_resources_string} in the search result."
      end  
    end

    def matched_base_resources(resource, referenced_resource_types, returned_resources_all, values_found)
      included_resources = returned_resources_all.select{|item| referenced_resource_types.include?(item.resourceType)}.map { |resource| "#{resource.resourceType}/#{resource.id}" }
  
      matched_base_resources = values_found.select do |base_resource_references|
        included_resources.any? do |referenced_resource|
          is_reference_match?(base_resource_references.reference, referenced_resource)
        end
      end
    end

    def is_reference_match? (reference, local_reference)
      regex_pattern = /^(#{Regexp.escape(local_reference)}|\S+\/#{Regexp.escape(local_reference)}(?:[\/|]\S+)*)$/
      reference.match?(regex_pattern)
    end

    def patient_id_param?(name)
      name == '_id' && resource_type == 'Patient'
    end
  end
end
