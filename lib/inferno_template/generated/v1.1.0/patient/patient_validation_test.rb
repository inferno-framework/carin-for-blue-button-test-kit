require_relative '../../../validation_test'
require_relative './patient_read_test'

module InfernoTemplate
  module CARIN4BBV110
    class PatientValidationTest < Inferno::Test
      include InfernoTemplate::ValidationTest
      include InfernoTemplate::CARIN4BBV110

      id :c4bb_v110_patient_validation_test
      title 'Patient resources returned during previous tests conform to the C4BB Patient'
      description %(
This test verifies resources returned from the first search conform to
the [C4BB Patient](http://hl7.org/fhir/us/carin-bb/StructureDefinition/C4BB-Patient).
Systems must demonstrate at least one valid example in order to pass this test.

It verifies the presence of mandatory elements and that elements with
required bindings contain appropriate values. CodeableConcept element
bindings will fail if none of their codings have a code/system belonging
to the bound ValueSet. Quantity, Coding, and code element bindings will
fail if their code/system are not found in the valueset.

      )

      output :dar_code_found, :dar_extension_found

      #uses_request :patient_request
      
      def resource_type
        'Patient'
      end

      def scratch_resources
        scratch[:patient_resources] ||= {}
      end

      def patient_resource
        CARIN4BBV110::PatientReadTest.new().patient_resource
      end 

      run do
        perform_validation_test([patient_resource] || [],
                                'http://hl7.org/fhir/us/carin-bb/StructureDefinition/C4BB-Patient',
                                '1.1.0',
                                skip_if_empty: true)
      end
    end
  end
end
