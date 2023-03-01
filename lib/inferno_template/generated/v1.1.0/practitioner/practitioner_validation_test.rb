require_relative '../../../validation_test'
require_relative './practitioner_read_test'

module InfernoTemplate
  module CARIN4BBV110
    class PractitionerValidationTest < Inferno::Test
      include InfernoTemplate::ValidationTest
      include InfernoTemplate::CARIN4BBV110

      id :c4bb_v110_practitioner_validation_test
      title 'Practitioner resources returned during previous tests conform to the C4BB Practitioner'
      description %(
This test verifies resources returned from the first search conform to
the [C4BB Practitioner](http://hl7.org/fhir/us/carin-bb/StructureDefinition/C4BB-Practitioner).
Systems must demonstrate at least one valid example in order to pass this test.

It verifies the presence of mandatory elements and that elements with
required bindings contain appropriate values. CodeableConcept element
bindings will fail if none of their codings have a code/system belonging
to the bound ValueSet. Quantity, Coding, and code element bindings will
fail if their code/system are not found in the valueset.

      )

      output :dar_code_found, :dar_extension_found

      #uses_request :practitioner_request
      
      def resource_type
        'Practitioner'
      end

      def scratch_resources
        scratch[:practitioner_resources] ||= {}
      end

      def practitioner_resource
        CARIN4BBV110::PractitionerReadTest.new().practitioner_resource
      end 

      run do
        perform_validation_test([practitioner_resource] || [],
                                'http://hl7.org/fhir/us/carin-bb/StructureDefinition/C4BB-Practitioner',
                                '1.1.0',
                                skip_if_empty: true)
      end
    end
  end
end
