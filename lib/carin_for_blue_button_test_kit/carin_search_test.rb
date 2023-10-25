# frozen_string_literal: true

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
                   :multiple_or_search_params

    def all_scratch_resources
      scratch_resources[:all] ||= []
    end

    def run_search_test(param_value, include_search: false, resource_id: nil)
      search_params = {}

      if include_search
        search_params = { _id: resource_id }
        run_include_search(search_params, param_value)
        return
      end

      search_params[search_param_names[0]] = param_value

      fhir_search(resource_type, params: search_params)
      assert_response_status(200)
      assert_resource_type(:bundle)

      returned_resources = extract_resources_from_bundle(bundle: resource, response:).select do |item|
        item.resourceType == resource_type
      end

      skip_if returned_resources.blank?, no_resources_message

      all_scratch_resources.concat(returned_resources).uniq! if first_search?

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
            resolve_path(resource.source_hash, path)
            .map do |value|
              value[:reference.to_s] || value
            end

          match_found = case type
                        when 'Reference'
                          values_found.any? do |val|
                            val.include? param_value
                          end
                        when 'CodeableConcept'
                          codings = values_found.flat_map do |val|
                            val[:coding.to_s] || nil
                          end.compact
                          if param_value.include? '|'
                            system = param_value.split('|').first
                            code = param_value.split('|').last
                            codings&.any? do |coding|
                              coding[:system.to_s] == system && coding[:code.to_s]&.casecmp?(code)
                            end
                          else
                            codings&.any? { |coding| coding[:code.to_s]&.casecmp?(param_value) }
                          end
                        when 'Identifier'
                          if param_value.include? '|'
                            values_found.any? do |identifier|
                              puts "#{identifier[:system.to_s]}|#{identifier[:value.to_s]}"
                              "#{identifier[:system.to_s]}|#{identifier[:value.to_s]}" == param_value
                            end
                          else
                            values_found.any? { |identifier| identifier[:value] == param_value }
                          end
                        when 'Period', 'date', 'instant', 'dateTime'
                          values_found.any? { |date| validate_date_search(param_value, date) }
                        when 'http://hl7.org/fhirpath/System.String'
                          param_value = param_value.split(',').map(&:strip)
                          values_found.any? { |str| param_value.include?(str) }
                        else
                          false
                        end

          break if match_found
        end
        assert match_found, 'Returned resource did not match the search parameter'
      end
    end

    def run_include_search(search_params, param_value)
      search_params['_include'] = param_value

      fhir_search(resource_type, params: search_params)
      assert_response_status(200)
      assert_resource_type(:bundle)

      returned_resources = extract_resources_from_bundle(bundle: resource, response:).select do |item|
        item.resourceType == resource_type
      end

      skip_if returned_resources.blank?, no_resources_message

      returned_resources.each do |resource|
        match_found = false
        paths = include_param_paths(param_value)

        if param_value != 'ExplanationOfBenefit:*'
          paths.each do |path|
            values_found = resolve_path(resource.source_hash, path)

            match_found = values_found.length.positive?

            break if match_found
          end
          assert match_found, 'Returned resource did not match the search parameter'
          return
        else
          values_found = []
          paths.each do |path|
            values_found += resolve_path(resource.source_hash, path)
          end

          match_found = (values_found.length >= 5)

          assert match_found, 'Returned resource did not match the search parameter'
        end
      end
    end

    def include_param_paths(param)
      case param
      when 'ExplanationOfBenefit:patient'
        ['patient']
      when 'ExplanationOfBenefit:provider'
        ['provider']
      when 'ExplanationOfBenefit:care-team'
        ['careTeam']
      when 'ExplanationOfBenefit:coverage'
        ['insurance.coverage']
      when 'ExplanationOfBenefit:insurer'
        ['insurer']
      when 'Coverage:payor'
        ['payor']
      when 'ExplanationOfBenefit:*'
        ['patient', 'provider', 'careTeam', 'insurance.coverage', 'insurer']
      else
        []
      end
    end
  end
end
