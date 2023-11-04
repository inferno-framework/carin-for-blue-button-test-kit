require_relative '../../../read_test'
require 'json'

module CarinForBlueButtonTestKit
  module CARIN4BBV200DEVNONFINANCIAL
    class ExplanationOfBenefitOutpatientInstitutionalNonFinancialReadTest < Inferno::Test
      include CarinForBlueButtonTestKit::ReadTest

      title 'Server returns correct ExplanationOfBenefit resource from ExplanationOfBenefit read interaction'
      description 'A server SHALL support the ExplanationOfBenefit read interaction.'

      id :c4bb_v200devnonfinancial_explanation_of_benefit_outpatient_institutional_non_financial_read_test

      input :explanation_of_benefit_outpatient_institutional_non_financial_ids,
        title: "explanation_of_benefit_outpatient_institutional_non_financial IDs",
        type: 'text',
        description: "Comma separated list of explanation_of_benefit_outpatient_institutional_non_financial IDs that in sum contain all MUST SUPPORT elements"

      input_order :url, :smart_credentials, :explanation_of_benefit_outpatient_institutional_non_financial_ids

      def resource_type
        'ExplanationOfBenefit'
      end

      def scratch_resources
        scratch[:explanation_of_benefit_outpatient_institutional_non_financial_resources] ||= {}
      end

      def explanation_of_benefit_outpatient_institutional_non_financial_id_list
        return [nil] unless respond_to? :explanation_of_benefit_outpatient_institutional_non_financial_ids
        explanation_of_benefit_outpatient_institutional_non_financial_ids.split(',').map(&:strip)
      end

      run do
        perform_read_test(explanation_of_benefit_outpatient_institutional_non_financial_id_list)
      end
    end
  end
end
