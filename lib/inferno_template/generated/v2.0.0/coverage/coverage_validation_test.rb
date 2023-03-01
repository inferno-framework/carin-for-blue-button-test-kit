require_relative '../../../validation_test'
require_relative './coverage_read_test'

module InfernoTemplate
  module CARIN4BBV200
    class CoverageValidationTest < Inferno::Test
      include InfernoTemplate::ValidationTest
      include InfernoTemplate::CARIN4BBV200

      id :c4bb_v200_coverage_validation_test
      title 'Coverage resources returned during previous tests conform to the C4BB Coverage'
      description %(
This test verifies resources returned from the first search conform to
the [C4BB Coverage](http://hl7.org/fhir/us/carin-bb/StructureDefinition/C4BB-Coverage).
Systems must demonstrate at least one valid example in order to pass this test.

It verifies the presence of mandatory elements and that elements with
required bindings contain appropriate values. CodeableConcept element
bindings will fail if none of their codings have a code/system belonging
to the bound ValueSet. Quantity, Coding, and code element bindings will
fail if their code/system are not found in the valueset.

      )

      output :dar_code_found, :dar_extension_found

      #uses_request :coverage_request
      
      def resource_type
        'Coverage'
      end

      def scratch_resources
        scratch[:coverage_resources] ||= {}
      end

      def coverage_resource
        CARIN4BBV200::CoverageReadTest.new().coverage_resource
      end 

      run do
        perform_validation_test([coverage_resource] || [],
                                'http://hl7.org/fhir/us/carin-bb/StructureDefinition/C4BB-Coverage',
                                '2.0.0',
                                skip_if_empty: true)
      end
    end
  end
end
