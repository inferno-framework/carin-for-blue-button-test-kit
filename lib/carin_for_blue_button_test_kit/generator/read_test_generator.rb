require_relative 'naming'

module CarinForBlueButtonTestKit
  class Generator
    class ReadTestGenerator
      class << self
        def generate(ig_metadata, base_output_dir)
          ig_metadata.groups
                     .select { |group| read_interaction(group).present? }
                     .each { |group| new(group, base_output_dir).generate }
        end

        def read_interaction(group_metadata)
          group_metadata.interactions.find { |interaction| interaction[:code] == 'read' }
        end
      end

      attr_accessor :group_metadata, :base_output_dir

      def initialize(group_metadata, base_output_dir)
        self.group_metadata = group_metadata
        self.base_output_dir = base_output_dir
      end

      def template
        @template ||= File.read(File.join(__dir__, 'templates', 'read.rb.erb'))
      end

      def output
        @output ||= ERB.new(template).result(binding)
      end

      def base_output_file_name
        file_name = class_name.underscore
        file_name.sub!("#{profile_identifier}_", '')
        "#{file_name}.rb"
      end

      def output_file_directory
        File.join(base_output_dir, profile_identifier)
      end

      def output_file_name
        File.join(output_file_directory, base_output_file_name)
      end

      def read_interaction
        self.class.read_interaction(group_metadata)
      end

      def profile_identifier
        Naming.snake_case_for_profile(group_metadata)
      end

      def test_id
        "c4bb_#{group_metadata.reformatted_version}_#{profile_identifier}_read_test"
      end

      def class_name
        "#{Naming.upper_camel_case_for_profile(group_metadata)}ReadTest"
      end

      def module_name
        "CARIN4BB#{group_metadata.reformatted_version.upcase}"
      end

      def resource_type
        group_metadata.resource
      end

      def specific_resource_type
        case profile_identifier
        when 'eob_inpatient_institutional'
          'ExplanationOfBenefitInpatientInstitutional'
        when 'eob_inpatient_institutional_nonfinancial'
          'ExplanationOfBenefitInpatientInstitutionalNonFinancial'
        when 'eob_oral'
          'ExplanationOfBenefitOral'
        when 'eob_oral_nonfinancial'
          'ExplanationOfBenefitOralNonFinancial'
        when 'eob_outpatient_institutional'
          'ExplanationOfBenefitOutpatientInstitutional'
        when 'eob_outpatient_institutional_nonfinancial'
          'ExplanationOfBenefitOutpatientInstitutionalNonFinancial'
        when 'eob_pharmacy'
          'ExplanationOfBenefitPharmacy'
        when 'eob_pharmacy_nonfinancial'
          'ExplanationOfBenefitPharmacyNonFinancial'
        when 'eob_professional_non_clinician'
          'ExplanationOfBenefitProfessionalNonClinician'
        when 'eob_professional_non_clinician_nonfinancial'
          'ExplanationOfBenefitProfessionalNonClinicianNonFinancial'
        else
          resource_type
        end
      end

      def resource_collection_string
        if group_metadata.delayed? && resource_type != 'Provenance'
          "scratch.dig(:references, '#{resource_type}')"
        else
          'all_scratch_resources'
        end
      end

      def conformance_expectation
        read_interaction[:expectation]
      end

      def search_params
        group_metadata.searches.map { |search| search[:names] }
                      .flatten
      end

      def generate
        FileUtils.mkdir_p(output_file_directory)
        File.open(output_file_name, 'w') { |f| f.write(output) }

        group_metadata.add_test(
          id: test_id,
          file_name: base_output_file_name
        )
      end

      def input_description
        desc_content = if profile_identifier == 'patient'
                         "
                          Comma separated list of patient IDs that in sum
                          contain all MUST SUPPORT elements
                          "
                       else
                         "#{profile_identifier} Resource ID"
                       end
        <<~INPUT_DESCRIPTION
          #{desc_content}
        INPUT_DESCRIPTION
      end
    end
  end
end
