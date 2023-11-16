require_relative '../../../carin_search_test'
require_relative '../../../generator/group_metadata'

module CarinForBlueButtonTestKit
  module CARIN4BBV200DEVNONFINANCIAL
    class ExplanationOfBenefitOutpatientInstitutionalNonFinancialExplanationOfBenefit_AllSearchTest < Inferno::Test
      include CarinForBlueButtonTestKit::CarinSearchTest

      title 'Server returns valid results for ExplanationOfBenefit search by id + _include=ExplanationOfBenefit:*'
      description %(Tests that the server responds correctly when using _include="ExplanationOfBenefit:*" as a search parameter 

      )

      def self.properties
        @properties ||= SearchTestProperties.new(
          resource_type: 'ExplanationOfBenefit',
        search_param_names: ['_include']
        )
      end

      id :c4bb_v200devnonfinancial_explanation_of_benefit_outpatient_institutional_non_financial_include_ExplanationOfBenefit_All_search_test

      input :c4bb_v200devnonfinancial_explanation_of_benefit_outpatient_institutional_non_financial__id_search_test_param,
        title: 'ExplanationOfBenefit search parameter for _id',
        type: 'text',
        description: 'ExplanationOfBenefit search parameter: _id'

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      run do
        run_include_search('ExplanationOfBenefit:*', resource_id: c4bb_v200devnonfinancial_explanation_of_benefit_outpatient_institutional_non_financial__id_search_test_param)
      end
    end
  end
end
