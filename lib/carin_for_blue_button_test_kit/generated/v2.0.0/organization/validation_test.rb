require_relative '../../../validation_test'
require_relative './read_test'

module CarinForBlueButtonTestKit
  module CARIN4BBV200
    class OrganizationValidationTest < Inferno::Test
      include CarinForBlueButtonTestKit::ValidationTest
      include CarinForBlueButtonTestKit::CARIN4BBV200

      id :c4bb_v200_organization_validation_test
      title 'Organization resources returned during previous tests conform to the C4BB Organization'
      description %(This test verifies resources returned from the first search conform to
the [C4BB Organization](http://hl7.org/fhir/us/carin-bb/StructureDefinition/C4BB-Organization).
Systems must demonstrate at least one valid example in order to pass this test.

It verifies the presence of mandatory elements and that elements with
required bindings contain appropriate values. CodeableConcept element
bindings will fail if none of their codings have a code/system belonging
to the bound ValueSet. Quantity, Coding, and code element bindings will
fail if their code/system are not found in the valueset.

      )
      verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@12'

      output :dar_code_found, :dar_extension_found

      def resource_type
        'Organization'
      end

      def scratch_resources
        scratch[:organization_resources] ||= {}
      end

      run do
        perform_validation_test(scratch_resources[:all] || [],
                                'http://hl7.org/fhir/us/carin-bb/StructureDefinition/C4BB-Organization',
                                '2.0.0',
                                skip_if_empty: true)
      end
    end
  end
end
