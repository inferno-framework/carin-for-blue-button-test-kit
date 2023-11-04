require_relative '../../../read_test'
require 'json'

module CarinForBlueButtonTestKit
  module CARIN4BBV200
    class ExplanationOfBenefitInpatientInstitutionalReadTest < Inferno::Test
      include CarinForBlueButtonTestKit::ReadTest

      title 'Server returns correct ExplanationOfBenefit resource from ExplanationOfBenefit read interaction'
      description 'A server SHALL support the ExplanationOfBenefit read interaction.'

      id :c4bb_v200_explanation_of_benefit_inpatient_institutional_read_test

      input :explanation_of_benefit_inpatient_institutional_ids,
        title: "explanation_of_benefit_inpatient_institutional IDs",
        type: 'text',
        description: "Comma separated list of explanation_of_benefit_inpatient_institutional IDs that in sum contain all MUST SUPPORT elements"

      input_order :url, :smart_credentials, :explanation_of_benefit_inpatient_institutional_ids

      def resource_type
        'ExplanationOfBenefit'
      end

      def scratch_resources
        scratch[:explanation_of_benefit_inpatient_institutional_resources] ||= {}
      end

      def explanation_of_benefit_inpatient_institutional_id_list
        return [nil] unless respond_to? :explanation_of_benefit_inpatient_institutional_ids
        explanation_of_benefit_inpatient_institutional_ids.split(',').map(&:strip)
      end

      run do
        perform_read_test(explanation_of_benefit_inpatient_institutional_id_list)
      end
    end
  end
end
