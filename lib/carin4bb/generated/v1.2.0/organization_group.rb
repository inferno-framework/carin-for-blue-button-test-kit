require_relative 'organization/organization_read_test'
    require_relative 'organization/organization_validation_test'
    require_relative 'organization/organization_must_support_test'
    
    module CARINForBlueButton
      module CARIN4BBV120
        class OrganizationGroup < Inferno::TestGroup
          title 'Organization Tests'
          short_description 'Verify support for the server capabilities required by the C4BB Organization.'
          description %(
      # Background

The CARIN for Blue Button Organization sequence verifies that the system under test is
able to provide correct responses for Organization queries. These queries
must contain resources conforming to the C4BB Organization as
specified in the CARIN for Blue Button v1.2.0 Implementation Guide.

# Testing Methodology


## Must Support
Each profile contains elements marked as "must support". This test
sequence expects to see each of these elements at least once. If at
least one cannot be found, the test will fail. The test will look
through the Organization resources found in the first test for these
elements.

## Profile Validation
Each resource returned from the first search is expected to conform to
the [C4BB Organization](http://hl7.org/fhir/us/carin-bb/StructureDefinition/C4BB-Organization). Each element is checked against
teminology binding and cardinality requirements.

Elements with a required binding are validated against their bound
ValueSet. If the code/system in the element is not part of the ValueSet,
then the test will fail.

## Reference Validation
At least one instance of each external reference in elements marked as
"must support" within the resources provided by the system must resolve.
The test will attempt to read each reference found and will fail if no
read succeeds.

          )
    
          id :c4bb_v120_organization
          run_as_group
    
          def self.metadata
            @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'organization', 'metadata.yml'), aliases: true))
          end
      
          test from: :c4bb_v120_organization_read_test
          test from: :c4bb_v120_organization_validation_test
          test from: :c4bb_v120_organization_must_support_test
        end
      end
    end
    