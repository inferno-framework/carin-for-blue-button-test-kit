require_relative '../../../validation_test'
require_relative './read_test'

module C4BBTestKit
  module CARIN4BBV200DEVNONFINANCIAL
    class PatientValidationTest < Inferno::Test
      include C4BBTestKit::ValidationTest
      include C4BBTestKit::CARIN4BBV200DEVNONFINANCIAL

      id :c4bb_v200devnonfinancial_patient_validation_test
      title 'Patient resources returned during previous tests conform to the C4BB Patient'
      description %(This test verifies resources returned from the first search conform to
the [C4BB Patient](http://hl7.org/fhir/us/carin-bb/StructureDefinition/C4BB-Patient).
Systems must demonstrate at least one valid example in order to pass this test.

It verifies the presence of mandatory elements and that elements with
required bindings contain appropriate values. CodeableConcept element
bindings will fail if none of their codings have a code/system belonging
to the bound ValueSet. Quantity, Coding, and code element bindings will
fail if their code/system are not found in the valueset.

      )

      output :dar_code_found, :dar_extension_found
      
      def resource_type
        'Patient'
      end

      def scratch_resources
        scratch[:patient_resources] ||= {}
      end

      run do
        perform_validation_test(scratch_resources[:all] || [],
                                'http://hl7.org/fhir/us/carin-bb/StructureDefinition/C4BB-Patient',
                                '2.0.0',
                                skip_if_empty: true)
      end
    end
  end
end
