require_relative '../../../carin_search_test'
require_relative '../../../generator/group_metadata'

module CarinForBlueButtonTestKit
  module CARIN4BBV200DEVNONFINANCIAL
    class ExplanationOfBenefitOutpatientInstitutionalNonFinancialServiceDateSearchTest < Inferno::Test
      include CarinForBlueButtonTestKit::CarinSearchTest

      title 'Server returns valid results for ExplanationOfBenefit search by service-date'
      description %(
A server SHALL support searching by
service-date on the ExplanationOfBenefit resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.


      )

      id :c4bb_v200devnonfinancial_explanation_of_benefit_outpatient_institutional_non_financial_service_date_search_test

      input :c4bb_v200devnonfinancial_explanation_of_benefit_outpatient_institutional_non_financial_service_date_search_test_param,
        title: 'ExplanationOfBenefit search parameter for service-date
',
        type: 'text',
        description: 'ExplanationOfBenefit search parameter: service-date
'

      def self.properties
        @properties ||= SearchTestProperties.new(
          resource_type: 'ExplanationOfBenefit',
        search_param_names: ['service-date']
        )
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:explanation_of_benefit_outpatient_institutional_non_financial_resources] ||= {}
      end

      run do
        
        run_search_test(c4bb_v200devnonfinancial_explanation_of_benefit_outpatient_institutional_non_financial_service_date_search_test_param)
      end
    end
  end
end
