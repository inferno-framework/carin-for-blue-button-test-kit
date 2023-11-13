require_relative '../../../carin_search_test'
require_relative '../../../generator/group_metadata'

module CarinForBlueButtonTestKit
  module CARIN4BBV200DEVNONFINANCIAL
    class ExplanationOfBenefitInpatientInstitutionalNonFinancialPatientSearchTest < Inferno::Test
      include CarinForBlueButtonTestKit::CarinSearchTest

      title 'Server returns valid results for ExplanationOfBenefit search by patient'
      description %(A server SHALL support searching by
patient on the ExplanationOfBenefit resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

This test verifies that the server supports searching by reference using
the form `patient=[id]` as well as `patient=Patient/[id]`. The two
different forms are expected to return the same number of results. CARIN requires that both forms are supported by CARIN for Blue Button responders.

Because this is the first search of the sequence, resources in the
response will be used for subsequent tests.

Additionally, this test will check that GET and POST search methods
return the same number of results. Search by POST is required by the
FHIR R4 specification, and these tests interpret search by GET as a
requirement of CARIN IG for Blue Button® v2.0.0-dev-nonfinancial.


      )

      id :c4bb_v200devnonfinancial_explanation_of_benefit_inpatient_institutional_non_financial_patient_search_test

      input :c4bb_v200devnonfinancial_explanation_of_benefit_inpatient_institutional_non_financial_patient_search_test_param,
        title: 'ExplanationOfBenefit search parameter for patient',
        type: 'text',
        description: 'ExplanationOfBenefit search parameter: patient'

      def self.properties
        @properties ||= SearchTestProperties.new(
          first_search: true,
          resource_type: 'ExplanationOfBenefit',
          search_param_names: ['patient'],
          saves_delayed_references: true,
          test_reference_variants: true,
          test_post_search: true
        )
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:explanation_of_benefit_inpatient_institutional_non_financial_resources] ||= {}
      end
      
      run do
        
        run_search_test(c4bb_v200devnonfinancial_explanation_of_benefit_inpatient_institutional_non_financial_patient_search_test_param)
      end
    end
  end
end
