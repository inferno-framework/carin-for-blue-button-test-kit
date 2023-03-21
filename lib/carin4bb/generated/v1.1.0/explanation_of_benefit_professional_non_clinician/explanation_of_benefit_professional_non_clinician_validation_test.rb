require_relative '../../../validation_test'
require_relative './explanation_of_benefit_professional_non_clinician_read_test'

module CARINForBlueButton
  module CARIN4BBV110
    class ExplanationOfBenefitProfessionalNonClinicianValidationTest < Inferno::Test
      include CARINForBlueButton::ValidationTest
      include CARINForBlueButton::CARIN4BBV110

      id :c4bb_v110_explanation_of_benefit_professional_non_clinician_validation_test
      title 'ExplanationOfBenefit resources returned during previous tests conform to the C4BB ExplanationOfBenefit Professional NonClinician'
      description %(
This test verifies resources returned from the first search conform to
the [C4BB ExplanationOfBenefit Professional NonClinician](http://hl7.org/fhir/us/carin-bb/StructureDefinition/C4BB-ExplanationOfBenefit-Professional-NonClinician).
Systems must demonstrate at least one valid example in order to pass this test.

It verifies the presence of mandatory elements and that elements with
required bindings contain appropriate values. CodeableConcept element
bindings will fail if none of their codings have a code/system belonging
to the bound ValueSet. Quantity, Coding, and code element bindings will
fail if their code/system are not found in the valueset.

      )

      output :dar_code_found, :dar_extension_found
      
      def resource_type
        'ExplanationOfBenefit'
      end

      def scratch_resources
        scratch[:explanation_of_benefit_professional_non_clinician_resources] ||= {}
      end

      run do
        perform_validation_test(scratch_resources[:all] || [],
                                'http://hl7.org/fhir/us/carin-bb/StructureDefinition/C4BB-ExplanationOfBenefit-Professional-NonClinician',
                                '1.1.0',
                                skip_if_empty: true)
      end
    end
  end
end
