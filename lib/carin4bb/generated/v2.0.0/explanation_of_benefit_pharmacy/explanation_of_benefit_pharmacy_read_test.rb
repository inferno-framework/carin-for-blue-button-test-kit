require_relative '../../../read_test'
require 'json'
require_relative '../../../ext/fhir_models'

module CARINForBlueButton
  module CARIN4BBV200
    class ExplanationOfBenefitPharmacyReadTest < Inferno::Test
      include CARINForBlueButton::ReadTest

      title 'Server returns correct ExplanationOfBenefit resource from ExplanationOfBenefit read interaction'
      description 'A server SHALL support the ExplanationOfBenefit read interaction.'

      id :c4bb_v200_explanation_of_benefit_pharmacy_read_test

      input :explanation_of_benefit_pharmacy_ids,
        title: "explanation_of_benefit_pharmacy IDs",
        type: 'text',
        description: "explanation_of_benefit_pharmacy Resource ID"
    
    
      #makes_request :explanation_of_benefit_pharmacy_request

      def resource_type
        'ExplanationOfBenefit'
      end

      def scratch_resources
        scratch[:explanation_of_benefit_pharmacy_resources] ||= {}
      end

      def explanation_of_benefit_pharmacy_resource
        #fhir_read(:explanation_of_benefit_pharmacy, explanation_of_benefit_pharmacy_ids)
        file = File.open('lib/carin4bb/ext/examples/explanation_of_benefit_pharmacy_ex_1.json', 'r')
        resource = FHIR::Json.from_json(file.read)
        resource
      end

      run do
        perform_read_test([explanation_of_benefit_pharmacy_resource])
      end
    end
  end
end
