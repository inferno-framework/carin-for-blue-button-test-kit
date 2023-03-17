require_relative '../../../read_test'
require 'json'
require_relative '../../../ext/fhir_models'

module CARINForBlueButton
  module CARIN4BBV120
    class ExplanationOfBenefitOutpatientInstitutionalReadTest < Inferno::Test
      include CARINForBlueButton::ReadTest

      title 'Server returns correct ExplanationOfBenefit resource from ExplanationOfBenefit read interaction'
      description 'A server SHALL support the ExplanationOfBenefit read interaction.'

      id :c4bb_v120_explanation_of_benefit_outpatient_institutional_read_test

      input :explanation_of_benefit_outpatient_institutional_ids,
        title: "explanation_of_benefit_outpatient_institutional IDs",
        type: 'text',
        description: "explanation_of_benefit_outpatient_institutional Resource ID"
    
    
      #makes_request :explanation_of_benefit_outpatient_institutional_request

      def resource_type
        'ExplanationOfBenefit'
      end

      def scratch_resources
        scratch[:explanation_of_benefit_outpatient_institutional_resources] ||= {}
      end

      def explanation_of_benefit_outpatient_institutional_resource
        #fhir_read(:explanation_of_benefit_outpatient_institutional, explanation_of_benefit_outpatient_institutional_ids)
        file = File.open('lib/carin4bb/ext/examples/explanation_of_benefit_outpatient_institutional_ex_1.json', 'r')
        resource = FHIR::Json.from_json(file.read)
        resource
      end

      run do
        perform_read_test([explanation_of_benefit_outpatient_institutional_resource])
      end
    end
  end
end
