require_relative '../../../validation_test'
require_relative './explanation_of_benefit_inpatient_institutional_read_test'

module CARINForBlueButton
  module CARIN4BBV120
    class ExplanationOfBenefitInpatientInstitutionalValidationTest < Inferno::Test
      include CARINForBlueButton::ValidationTest
      include CARINForBlueButton::CARIN4BBV120

      id :c4bb_v120_explanation_of_benefit_inpatient_institutional_validation_test
      title 'ExplanationOfBenefit resources returned during previous tests conform to the C4BB ExplanationOfBenefit Inpatient Institutional'
      description %(
This test verifies resources returned from the first search conform to
the [C4BB ExplanationOfBenefit Inpatient Institutional](http://hl7.org/fhir/us/carin-bb/StructureDefinition/C4BB-ExplanationOfBenefit-Inpatient-Institutional).
Systems must demonstrate at least one valid example in order to pass this test.

It verifies the presence of mandatory elements and that elements with
required bindings contain appropriate values. CodeableConcept element
bindings will fail if none of their codings have a code/system belonging
to the bound ValueSet. Quantity, Coding, and code element bindings will
fail if their code/system are not found in the valueset.

      )

      output :dar_code_found, :dar_extension_found

      #uses_request :explanation_of_benefit_inpatient_institutional_request
      
      def resource_type
        'ExplanationOfBenefit'
      end

      def scratch_resources
        scratch[:explanation_of_benefit_inpatient_institutional_resources] ||= {}
      end

      def explanation_of_benefit_inpatient_institutional_resource
        CARIN4BBV120::ExplanationOfBenefitInpatientInstitutionalReadTest.new().explanation_of_benefit_inpatient_institutional_resource
      end 

      run do
        perform_validation_test([explanation_of_benefit_inpatient_institutional_resource] || [],
                                'http://hl7.org/fhir/us/carin-bb/StructureDefinition/C4BB-ExplanationOfBenefit-Inpatient-Institutional',
                                '1.2.0',
                                skip_if_empty: true)
      end
    end
  end
end
