require_relative '../../../validation_test'
require_relative './read_test'

module C4BBTestKit
  module CARIN4BBV200DEVNONFINANCIAL
    class EobOralNonFinancialValidationTest < Inferno::Test
      include C4BBTestKit::ValidationTest
      include C4BBTestKit::CARIN4BBV200DEVNONFINANCIAL

      id :c4bb_v200devnonfinancial_eob_oral_non_financial_validation_test
      title 'ExplanationOfBenefit resources returned during previous tests conform to the C4BB ExplanationOfBenefit Oral - Non-Financial'
      description %(This test verifies resources returned from the first search conform to
the [C4BB ExplanationOfBenefit Oral - Non-Financial](http://hl7.org/fhir/us/carin-bb/StructureDefinition/C4BB-ExplanationOfBenefit-Oral-NonFinancial).
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
        scratch[:eob_oral_non_financial_resources] ||= {}
      end

      run do
        perform_validation_test(scratch_resources[:all] || [],
                                'http://hl7.org/fhir/us/carin-bb/StructureDefinition/C4BB-ExplanationOfBenefit-Oral-NonFinancial',
                                '2.0.0',
                                skip_if_empty: true)
      end
    end
  end
end
