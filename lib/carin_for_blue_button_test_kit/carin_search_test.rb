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
                   :multiple_or_search_params,
                   :include_parameters

    def all_scratch_resources
      scratch_resources[:all] ||= []
    end

    def run_search_test(param_value = nil)
      search_params = build_search_params(param_value)
      returned_resources = execute_search(search_params)

      all_scratch_resources.concat(returned_resources).uniq! if first_search?
      save_delayed_references(returned_resources) if saves_delayed_references?
      perform_response_validation(returned_resources, search_params)
    end

    def execute_search(search_params)
      if patient_id_param?(search_param_names[0])
        patient_id_list.inject([]) do |resources, id|
          search = { search_param_names[0] => id }
          perform_search_and_validate(search)
          resources.concat(extract_relevant_resources)
        end
      else
        perform_search_and_validate(search_params)
        extract_relevant_resources
      end
    end

    def perform_search_and_validate(search_params)
      fhir_search(resource_type, params: search_params)

      assert_response_status(200)
      assert_resource_type(:bundle)
    end

    def extract_relevant_resources
      extract_resources_from_bundle(bundle: resource, response:).select do |item|
        item.resourceType == resource_type
      end
    end

    def build_search_params(param_value = nil)
      search_params = {}
      param_name = search_param_names[0]

      if patient_id_param?(param_name)
        search_params[param_name] = patient_id_list.join(',')
      else
        param_value = find_param_value(param_value, param_name) if param_value.blank?
        skip_if param_value.blank?, no_resources_skip_message
        search_params[param_name] = param_value
      end

      search_params
    end

    def find_param_value(param_value, param_name)
      all_scratch_resources.each do |resource|
        break if param_value.present?

        param_value = search_param_value(param_name, resource)
      end

      if param_value.nil? && param_name == '_id' && resource_type != 'ExplanationOfBenefit'
        resources = readable_resources(scratch.dig(:references, resource_type))
        param_value = resource_id(resources.first)
      end

      param_value
    end

    def search_param_value(name, resource, include_system = false)
      paths = determine_paths(name)
      paths.each do |path|
        element = find_a_value_at(resource, path) { |el| element_has_valid_value?(el, include_system) }
        search_value = process_element(name, element, include_system, resource)
        return search_value.gsub(',', '\\,') if search_value.present?
      end
      nil
    end

    # Handles the processing logic for each resource element type.
    def process_element(name, element, include_system, resource)
      case element
      when FHIR::Period
        process_period_element(element)
      when FHIR::Reference
        element.reference
      when FHIR::CodeableConcept
        process_codeable_concept_element(element, include_system)
      when FHIR::Identifier
        include_system ? "#{element.system}|#{element.value}" : element.value
      when FHIR::Coding
        include_system ? "#{element.system}|#{element.code}" : element.code
      when FHIR::HumanName
        element.family || element.given&.first || element.text
      when FHIR::Address
        element.text || element.city || element.state || element.postalCode || element.country
      else
        process_other_element_types(name, element, resource)
      end
    end

    # Handles logic for processing FHIR::Period elements.
    def process_period_element(element)
      if element.start.present?
        "gt#{(DateTime.xmlschema(element.start) - 1).xmlschema}"
      else
        end_datetime = get_fhir_datetime_range(element.end)[:end]
        "lt#{(end_datetime + 1).xmlschema}"
      end
    end

    # Handles logic for processing FHIR::CodeableConcept elements.
    def process_codeable_concept_element(element, include_system)
      if include_system
        coding = find_a_value_at(element, 'coding') { |c| c.code.present? && c.system.present? }
        "#{coding.system}|#{coding.code}"
      else
        find_a_value_at(element, 'coding.code')
      end
    end

    #  Handles the remaining types, including date types
    def process_other_element_types(name, element, resource)
      type = metadata.search_definitions[name.to_sym][:type]
      if type == 'date' && params_with_comparators&.include?(name)
        process_date_element(name, element, resource)
      else
        element
      end
    end

    def process_date_element(element)
      if /^\d{4}(-\d{2})?$/.match?(element) || # YYYY or YYYY-MM
         (/^\d{4}-\d{2}-\d{2}$/.match?(element) && resource_type != 'Goal') # YYYY-MM-DD AND Resource is NOT Goal
        "gt#{(DateTime.xmlschema(element) - 1).xmlschema}"
      else
        element
      end
    end

    def readable_resources(resources)
      return [] if resources.nil?

      resources
        .select { |resource| resource.is_a?(resource_class) || resource.is_a?(FHIR::Reference) }
        .select { |resource| (resource.is_a?(FHIR::Reference) ? resource.reference.split('/').last : resource.id).present? }
        .compact
        .uniq { |resource| resource.is_a?(FHIR::Reference) ? resource.reference.split('/').last : resource.id }
    end

    def resource_id(resource)
      return if resource.blank?

      resource.is_a?(FHIR::Reference) ? resource.reference.split('/').last : resource.id
    end

    def perform_response_validation(returned_resources, search_params)
      skip_if returned_resources.blank?, no_resources_skip_message

      returned_resources.each do |resource|
        check_resource_against_params(resource, search_params)
      end
    end

    def check_resource_against_params(resource, search_params)
      search_params.each do |name, param_value|
        paths = determine_paths(name)
        type = determine_type(name)
        assert check_paths_for_match(resource, paths, type, param_value),
               'Returned resource did not match the search parameter'
      end
    end

    # Determines the path based on the param name
    def determine_paths(name)
      case name
      when '_id'
        ['id']
      when '_lastUpdated'
        ['meta.lastUpdated']
      else
        search_param_paths(name)
      end
    end

    # Determines the param type based on the param name
    def determine_type(name)
      case name
      when '_id'
        'http://hl7.org/fhirpath/System.String'
      when '_lastUpdated'
        'date'
      else
        metadata.search_definitions[name.to_sym][:type]
      end
    end

    # Checks if any of the paths have a matching value
    def check_paths_for_match(resource, paths, type, param_value)
      paths.any? do |path|
        values_found = extract_values(resource, path, type)
        match_found?(values_found, type, param_value)
      end
    end

    # Extracts values from the resource based on the path and type
    def extract_values(resource, path, type)
      resolve_path(resource, path).map do |value|
        type == 'Reference' ? value.try(:reference) : value
      end
    end

    # Determines if a match is found based on the type and value
    def match_found?(values_found, type, param_value)
      case type
      when 'Reference'
        values_found.any? { |val| param_value.split(',').any? { |item| val.include?(item) } }
      when 'CodeableConcept'
        codings = values_found.flat_map { |val| val.coding || nil }.compact
        if param_value.include? '|'
          system, code = param_value.split('|', 2)
          codings.any? { |coding| coding.system == system && coding.code&.casecmp?(code) }
        else
          codings.any? { |coding| coding.code&.casecmp?(param_value) }
        end
      when 'Identifier'
        if param_value.include? '|'
          values_found.any? do |identifier|
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
    end

    def extract_resources_from_bundle(
      bundle: nil,
      response: nil,
      reply_handler: nil,
      max_pages: 20
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

    def element_has_valid_value?(element, include_system)
      case element
      when FHIR::Reference
        element.reference.present?
      when FHIR::CodeableConcept
        if include_system
          coding =
            find_a_value_at(element, 'coding') { |koding| koding.code.present? && koding.system.present? }
          coding.present?
        else
          find_a_value_at(element, 'coding.code').present?
        end
      when FHIR::Identifier
        include_system ? element.value.present? && element.system.present? : element.value.present?
      when FHIR::Coding
        include_system ? element.code.present? && element.system.present? : element.code.present?
      when FHIR::HumanName
        (element.family || element.given&.first || element.text).present?
      when FHIR::Address
        (element.text || element.city || element.state || element.postalCode || element.country).present?
      else
        true
      end
    end

    def search_param_paths(name)
      paths = metadata.search_definitions[name.to_sym][:paths]
      paths[0] = 'local_class' if paths.first == 'class'

      paths
    end

    def resource_class
      FHIR.const_get(resource_type)
    end

    def no_resources_skip_message(resource_type = self.resource_type)
      msg = "No #{resource_type} resources appear to be available"

      "#{msg}. Please use patients with more information"
    end

    def run_include_search(param_value)
      search_params = initialize_include_search_params(param_value)
      perform_search_and_validate(search_params)
      returned_resources = extract_resources_from_bundle(bundle: resource, response:)
      process_resources(returned_resources, param_value)
    end

    # Initializes seach param for include search
    def initialize_include_search_params(param_value)
      resource_id = all_scratch_resources.first&.id
      { _id: resource_id, '_include': param_value }
    end

    #  Processes the base resources and included resources for include searches
    def process_resources(returned_resources, param_value)
      base_resources = filter_base_resources(returned_resources)
      all_included_resource_types = extract_included_resource_types
      included_refs = included_refs(returned_resources, all_included_resource_types)

      skip_if base_resources.blank?, no_resources_skip_message

      base_resources.each do |resource|
        process_each_base_resource(resource, param_value, returned_resources, included_refs)
      end
    end

    def filter_base_resources(returned_resources)
      returned_resources.select { |item| item.resourceType == resource_type }
    end

    def extract_included_resource_types
      include_parameters.map { |param| param[:target] }.flatten.uniq
    end

    # Handles the processing for each base resource of an include search

    def process_each_base_resource(resource, param_value, returned_resources, included_refs)
      match_found, base_resource_matches = check_for_include_match(resource, param_value, returned_resources)
      assert match_found, 'Returned resource did not match the search parameter'
      validate_included_resources(base_resource_matches, included_refs)
    end

    def check_for_include_match(resource, param_value, returned_resources)
      if param_value != 'ExplanationOfBenefit:*'
        check_normal_include(resource, param_value, returned_resources)
      else
        check_explanation_of_benefit_include(resource, param_value, returned_resources)
      end
    end

    # Processes the base resource for the normal include case.
    def check_normal_include(resource, _param_value, returned_resources)
      base_resource_matches = []
      match_found = include_parameters.any? do |include_param|
        values_found = resolve_path(resource, include_param[:path])
        base_resource_matches.concat(matched_base_resources(resource, include_param[:target], returned_resources,
                                                            values_found))
        values_found.length.positive?
      end
      [match_found, base_resource_matches]
    end

    # Processes the base resource for the 'ExplanationOfBenefit:*' case.
    def check_explanation_of_benefit_include(resource, _param_value, returned_resources)
      values_found = []
      base_resource_matches = []

      include_parameters.each do |include_param|
        paths_found = resolve_path(resource, include_param[:path])
        values_found.concat(paths_found)
        base_resource_matches.concat(matched_base_resources(resource, include_param[:target], returned_resources,
                                                            values_found))
      end

      match_found = (values_found.length >= 5)
      [match_found, base_resource_matches]
    end

    # Validates that the included resources match the search criteria.
    def validate_included_resources(base_resource_matches, included_refs)
      not_matched_included_resources = included_refs.select do |resource_reference|
        base_resource_matches.none? do |base_resource_reference|
          reference_match?(base_resource_reference.reference, resource_reference)
        end
      end
      not_matched_included_resources_string = not_matched_included_resources.join(',')
      assert not_matched_included_resources.empty?,
             "No #{resource_type} references #{not_matched_included_resources_string} in the search result."
    end

    def matched_base_resources(_resource, referenced_resource_types, returned_resources_all, values_found)
      included_refs = included_refs(returned_resources_all, referenced_resource_types)

      values_found.select do |base_resource_references|
        included_refs.any? do |referenced_resource|
          reference_match?(base_resource_references.reference, referenced_resource)
        end
      end
    end

    def included_resources(returned_resources, referenced_resource_types)
      returned_resources.select { |item| referenced_resource_types.include?(item.resourceType) }
    end

    def included_refs(returned_resources, referenced_resource_types)
      included_resources(returned_resources, referenced_resource_types)
        .map { |resource| "#{resource.resourceType}/#{resource.id}" }
    end

    def reference_match?(reference, local_reference)
      regex_pattern = %r{^(#{Regexp.escape(local_reference)}|\S+/#{Regexp.escape(local_reference)}(?:[/|]\S+)*)$}
      reference.match?(regex_pattern)
    end

    def patient_id_param?(name)
      (name == '_id' && resource_type == 'Patient') || name == 'patient'
    end

    def patient_id_list
      return [nil] unless respond_to? :patient_ids

      patient_ids.split(',').map(&:strip)
    end

    def references_to_save
      metadata.delayed_references
    end

    def save_resource_reference(resource_type, reference)
      scratch[:references] ||= {}
      scratch[:references][resource_type] ||= Set.new
      scratch[:references][resource_type] << reference
    end

    def save_delayed_references(resources)
      resources.each do |resource|
        references_to_save.each do |reference_to_save|
          resolve_path(resource, reference_to_save[:path])
            .select { |reference| reference.is_a?(FHIR::Reference) && !reference.contained? }
            .each do |reference|
              resource_type = reference.resource_class.name.demodulize
              need_to_save = reference_to_save[:resources].include?(resource_type)
              next unless need_to_save

              save_resource_reference(resource_type, reference)
            end
        end
      end
    end
  end
end
