require_relative '../../../carin_search_test'
require_relative '../../../generator/group_metadata'

module CarinForBlueButtonTestKit
  module CARIN4BBV200
    class ExplanationOfBenefitPharmacyPatientSearchTest < Inferno::Test
      include CarinForBlueButtonTestKit::CarinSearchTest

      title 'Server returns valid results for ExplanationOfBenefit search by patient'
      description %(
A server SHALL support searching by
patient on the ExplanationOfBenefit resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.


      )

      id :c4bb_v200_explanation_of_benefit_pharmacy_patient_search_test

      input :c4bb_v200_explanation_of_benefit_pharmacy_patient_search_test_param,
        title: 'ExplanationOfBenefit search parameter for patient
',
        type: 'text',
        description: 'ExplanationOfBenefit search parameter: patient
'

      def self.properties
        @properties ||= SearchTestProperties.new(
          resource_type: 'ExplanationOfBenefit',
        search_param_names: ['patient']
        )
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:explanation_of_benefit_pharmacy_resources] ||= {}
      end

      run do
        run_search_test(c4bb_v200_explanation_of_benefit_pharmacy_patient_search_test_param)
      end
    end
  end
end
