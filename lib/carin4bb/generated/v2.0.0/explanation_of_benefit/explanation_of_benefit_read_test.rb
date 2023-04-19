require_relative '../../../read_test'
require 'json'
require_relative '../../../ext/fhir_models'

module CarinForBlueButtonTestKit
  module CARIN4BBV200
    class ExplanationOfBenefitReadTest < Inferno::Test
      include CarinForBlueButtonTestKit::ReadTest

      title 'Server returns correct ExplanationOfBenefit resource from ExplanationOfBenefit read interaction'
      description 'A server SHALL support the ExplanationOfBenefit read interaction.'

      id :c4bb_v200_explanation_of_benefit_read_test

      input :explanation_of_benefit_ids,
        title: "explanation_of_benefit IDs",
        type: 'text',
        description: "explanation_of_benefit Resource ID"

      input_order :url, :smart_credentials, :explanation_of_benefit_ids
      
      def resource_type
        'ExplanationOfBenefit'
      end

      def scratch_resources
        scratch[:explanation_of_benefit_resources] ||= {}
      end

      def explanation_of_benefit_id_list
        return [nil] unless respond_to? :explanation_of_benefit_ids
        explanation_of_benefit_ids.split(',').map(&:strip)
      end

      run do
        perform_read_test(explanation_of_benefit_id_list)
      end
    end
  end
end
