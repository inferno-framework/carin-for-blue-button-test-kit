require_relative '../../../read_test'
require 'json'

module CarinForBlueButtonTestKit
  module CARIN4BBV110
    class ExplanationOfBenefitOutpatientInstitutionalReadTest < Inferno::Test
      include CarinForBlueButtonTestKit::ReadTest

      title 'Server returns correct ExplanationOfBenefit resource from ExplanationOfBenefit read interaction'
      description 'A server SHALL support the ExplanationOfBenefit read interaction.'

      id :c4bb_v110_explanation_of_benefit_outpatient_institutional_read_test

      input :explanation_of_benefit_outpatient_institutional_ids,
        title: "explanation_of_benefit_outpatient_institutional IDs",
        type: 'text',
        description: "explanation_of_benefit_outpatient_institutional Resource ID"

      input_order :url, :smart_credentials, :explanation_of_benefit_outpatient_institutional_ids

      def resource_type
        'ExplanationOfBenefit'
      end

      def scratch_resources
        scratch[:explanation_of_benefit_outpatient_institutional_resources] ||= {}
      end

      def explanation_of_benefit_outpatient_institutional_id_list
        return [nil] unless respond_to? :explanation_of_benefit_outpatient_institutional_ids
        explanation_of_benefit_outpatient_institutional_ids.split(',').map(&:strip)
      end

      run do
        perform_read_test(explanation_of_benefit_outpatient_institutional_id_list)
      end
    end
  end
end
