# frozen_string_literal: true

require_relative 'naming'

module CarinForBlueButtonTestKit
  class Generator
    class GroupGenerator
      class << self
        def generate(ig_metadata, base_output_dir)
          @@eob_subgroups = ig_metadata.eob_subgroups
          ig_metadata.ordered_groups
                     .each { |group| new(group, base_output_dir).generate }
        end
      end

      attr_accessor :group_metadata, :base_output_dir

      def initialize(group_metadata, base_output_dir)
        self.group_metadata = group_metadata
        self.base_output_dir = base_output_dir
      end

      def template
        @template ||= File.read(File.join(__dir__, 'templates', 'group.rb.erb'))
      end

      def output
        @output ||= ERB.new(template, trim_mode: '-').result(binding)
      end

      def base_output_file_name
        "#{class_name.underscore}.rb"
      end

      def base_metadata_file_name
        'metadata.yml'
      end

      def class_name
        "#{Naming.upper_camel_case_for_profile(group_metadata)}Group"
      end

      def module_name
        "CARIN4BB#{group_metadata.reformatted_version.upcase}"
      end

      def title
        group_metadata.title
      end

      def short_description
        group_metadata.short_description
      end

      def output_file_name
        File.join(base_output_dir, base_output_file_name)
      end

      def metadata_file_name
        File.join(base_output_dir, profile_identifier, base_metadata_file_name)
      end

      def profile_identifier
        Naming.snake_case_for_profile(group_metadata)
      end

      def group_id
        "c4bb_#{group_metadata.reformatted_version}_#{profile_identifier}"
      end

      def resource_type
        group_metadata.resource
      end

      def search_validation_resource_type
        "#{resource_type} resources"
      end

      def profile_name
        group_metadata.profile_name
      end

      def profile_url
        group_metadata.profile_url
      end

      def optional?
        group_metadata.conformance_expectation != 'SHALL'
      end

      def generate
        if !is_eob_subgroup?
          File.open(output_file_name, 'w') { |f| f.write(output) }
          group_metadata.id = group_id
          group_metadata.file_name = base_output_file_name
        end
        File.open(metadata_file_name, 'w') { |f| f.write(YAML.dump(group_metadata.to_hash)) }
      end

      def test_id_list
        @test_id_list ||=
          group_metadata.tests.map { |test| test[:id] }

        # Remove calls to search tests for EOB subgroups and merge EOB subgroup tests with the EOB root tests
        @test_id_list = @test_id_list.reject { |test_name| test_name.include?('search_test') } if is_eob_subgroup?

        @test_id_list.concat(eob_subgroups_test_id_list) if is_eob_root_group?
        @test_id_list
      end

      def eob_subgroups_test_id_list
        test_id_list = []
        @@eob_subgroups.each do |group|
          test_id_list.concat(group.tests.map { |test| test[:id] })
        end

        test_id_list.reject { |test_name| test_name.include?('search_test') }
                    .reject { |test_name| test_name.include?('read_test') }
      end

      def test_file_list
        @test_file_list ||=
          group_metadata.tests.map do |test|
            name_without_suffix = test[:file_name].delete_suffix('.rb')
            name_without_suffix.start_with?('..') ? name_without_suffix : "#{profile_identifier}/#{name_without_suffix}"
          end

        # Remove calls to search tests for EOB subgroups (all subgroup search tests handled in EOB root tests)
        @test_file_list = @test_file_list.reject { |test_name| test_name.include?('search_test') } if is_eob_subgroup?

        @test_file_list = @test_file_list.concat(eob_subgroups_test_file_list) if is_eob_root_group?
        @test_file_list
      end

      def eob_subgroups_test_file_list
        test_file_list = []
        @@eob_subgroups.each do |group|
          list = group.tests.map do |test|
            name_without_suffix = test[:file_name].delete_suffix('.rb')
            name_without_suffix.start_with?('..') ? name_without_suffix : "#{Naming.snake_case_for_profile(group)}/#{name_without_suffix}"
          end
          test_file_list.concat(list)
        end
        test_file_list.reject { |test_name| test_name.include?('search_test') }
                      .reject { |test_name| test_name.include?('read_test') }
      end

      def required_searches
        if !group_metadata.searches.nil? && !is_eob_subgroup?
          group_metadata.searches.select { |search| search[:expectation] == 'SHALL' }
        else
          []
        end
      end

      def search_param_name_string
        required_searches
          .map { |search| search[:names].join(' + ') }
          .map { |names| "* #{names}" }
          .join("\n")
      end

      def search_description
        return '' if required_searches.blank?

        <<~SEARCH_DESCRIPTION
          ## Searching
          This test sequence will first perform each required search associated
          with this resource. This sequence will perform searches with the
          following parameters:

          #{search_param_name_string}

          ### Search Parameters
          The first search uses the selected patient(s) from the prior launch
          sequence. Any subsequent searches will look for its parameter values
          from the results of the first search. For example, the `identifier`
          search in the patient sequence is performed by looking for an existing
          `Patient.identifier` from any of the resources returned in the `_id`
          search. If a value cannot be found this way, the search is skipped.

          ### Search Validation
          Inferno will retrieve up to the first 20 bundle pages of the reply for
          #{search_validation_resource_type} and save them for subsequent tests.
          Each resource is then checked to see if it matches the searched
          parameters in accordance with [FHIR search
          guidelines](https://www.hl7.org/fhir/search.html). The test will fail,
          for example, if a Patient search for `gender=male` returns a `female`
          patient.
        SEARCH_DESCRIPTION
      end

      def description
        <<~DESCRIPTION
          # Background

          The CARIN for Blue Button #{title} sequence verifies that the system under test is
          able to provide correct responses for #{resource_type} queries. These queries
          must contain resources conforming to the #{profile_name} as
          specified in the CARIN for Blue Button #{group_metadata.version} Implementation Guide.

          # Testing Methodology
          #{search_description}

          ## Must Support
          Each profile contains elements marked as "must support". This test
          sequence expects to see each of these elements at least once. If at
          least one cannot be found, the test will fail. The test will look
          through the #{resource_type} resources found in the first test for these
          elements.

          ## Profile Validation
          Each resource returned from the first search is expected to conform to
          the [#{profile_name}](#{profile_url}). Each element is checked against
          terminology binding and cardinality requirements.

          Elements with a required binding are validated against their bound
          ValueSet. If the code/system in the element is not part of the ValueSet,
          then the test will fail.

          ## Reference Validation
          At least one instance of each external reference in elements marked as
          "must support" within the resources provided by the system must resolve.
          The test will attempt to read each reference found and will fail if no
          read succeeds.
        DESCRIPTION
      end

      def is_eob_subgroup?
        base_output_file_name.match(/eob_.+_group/)
      end

      def is_eob_root_group?
        resource_type == 'ExplanationOfBenefit' && !is_eob_subgroup?
      end
    end
  end
end
