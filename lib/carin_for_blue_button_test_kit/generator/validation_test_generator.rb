require_relative 'naming'

module CarinForBlueButtonTestKit
  class Generator
    class ValidationTestGenerator
      class << self
        def generate(ig_metadata, base_output_dir)
          ig_metadata.groups
            .each do |group|
              new(group, base_output_dir: base_output_dir).generate
            end
        end
      end

      attr_accessor :group_metadata, :medication_request_metadata, :base_output_dir

      def initialize(group_metadata, medication_request_metadata = nil, base_output_dir:)
        self.group_metadata = group_metadata
        self.medication_request_metadata = medication_request_metadata
        self.base_output_dir = base_output_dir
      end

      def template
        @template ||= File.read(File.join(__dir__, 'templates', 'validation.rb.erb'))
      end

      def output
        @output ||= ERB.new(template, trim_mode: '-').result(binding)
      end

      def base_output_file_name
        file_name = class_name.underscore
        file_name.sub!("#{profile_identifier}_", '')
        "#{file_name}.rb"
      end

      def output_file_directory
        File.join(base_output_dir, directory_name)
      end

      def output_file_name
        File.join(output_file_directory, base_output_file_name)
      end

      def directory_name
        Naming.snake_case_for_profile(medication_request_metadata || group_metadata)
      end

      def profile_identifier
        Naming.snake_case_for_profile(group_metadata)
      end

      def profile_url
        group_metadata.profile_url
      end

      def profile_name
        group_metadata.profile_name
      end

      def profile_version
        group_metadata.profile_version
      end

      def test_id
        "c4bb_#{group_metadata.reformatted_version}_#{profile_identifier}_validation_test"
      end

      def class_name
        "#{Naming.upper_camel_case_for_profile(group_metadata)}ValidationTest"
      end

      def module_name
        "CARIN4BB#{group_metadata.reformatted_version.upcase}"
      end

      def resource_type
        group_metadata.resource
      end

      def conformance_expectation
        read_interaction[:expectation]
      end

      def specific_resource_type
        case profile_identifier
        when 'eob_inpatient_institutional'
          return "ExplanationOfBenefitInpatientInstitutional"
        when 'eob_oral'
          return "ExplanationOfBenefitOral"
        when 'eob_outpatient_institutional'
          return "ExplanationOfBenefitOutpatientInstitutional"
        when 'eob_pharmacy'
          return "ExplanationOfBenefitPharmacy"
        when 'eob_professional_non_clinician'
          return "ExplanationOfBenefitProfessionalNonClinician"
        else
          return self.resource_type
        end
      end

      def skip_if_empty
        # Return true if a system must demonstrate at least one example of the resource type.
        # This drives omit vs. skip result statuses in this test.
        resource_type != 'Medication'
      end

      def generate
        FileUtils.mkdir_p(output_file_directory)
        File.open(output_file_name, 'w') { |f| f.write(output) }

        test_metadata = {
          id: test_id,
          file_name: base_output_file_name
        }
          group_metadata.add_test(**test_metadata)
      end

      def description
        <<~DESCRIPTION
        #{description_intro}
        It verifies the presence of mandatory elements and that elements with
        required bindings contain appropriate values. CodeableConcept element
        bindings will fail if none of their codings have a code/system belonging
        to the bound ValueSet. Quantity, Coding, and code element bindings will
        fail if their code/system are not found in the valueset.
        DESCRIPTION
      end

      def description_intro
          <<~GENERIC_INTRO
          This test verifies resources returned from the first search conform to
          the [#{profile_name}](#{profile_url}).
          Systems must demonstrate at least one valid example in order to pass this test.
          GENERIC_INTRO
      end
    end
  end
end
