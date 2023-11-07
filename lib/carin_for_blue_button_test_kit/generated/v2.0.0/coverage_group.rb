require_relative 'coverage/coverage_id_search_test'
    require_relative 'coverage/coverage_lastupdated_search_test'
    require_relative 'coverage/coverage_coverage_payor_search_test'
    require_relative 'coverage/coverage_read_test'
    require_relative 'coverage/coverage_validation_test'
    require_relative 'coverage/coverage_must_support_test'
    
    module CarinForBlueButtonTestKit
      module CARIN4BBV200
        class CoverageGroup < Inferno::TestGroup
          title 'Coverage Tests'
          short_description 'Verify support for the server capabilities required by the C4BB Coverage.'
          description %(# Background

The CARIN for Blue Button Coverage sequence verifies that the system under test is
able to provide correct responses for Coverage queries. These queries
must contain resources conforming to the C4BB Coverage as
specified in the CARIN for Blue Button v2.0.0 Implementation Guide.

# Testing Methodology
## Searching
This test sequence will first perform each required search associated
with this resource. This sequence will perform searches with the
following parameters:

* _id

### Search Parameters
The first search uses the selected patient(s) from the prior launch
sequence. Any subsequent searches will look for its parameter values
from the results of the first search. For example, the `identifier`
search in the patient sequence is performed by looking for an existing
`Patient.identifier` from any of the resources returned in the `_id`
search. If a value cannot be found this way, the search is skipped.

### Search Validation
Inferno will retrieve up to the first 20 bundle pages of the reply for
Coverage resources and save them for subsequent tests.
Each resource is then checked to see if it matches the searched
parameters in accordance with [FHIR search
guidelines](https://www.hl7.org/fhir/search.html). The test will fail,
for example, if a Patient search for `gender=male` returns a `female`
patient.


## Must Support
Each profile contains elements marked as "must support". This test
sequence expects to see each of these elements at least once. If at
least one cannot be found, the test will fail. The test will look
through the Coverage resources found in the first test for these
elements.

## Profile Validation
Each resource returned from the first search is expected to conform to
the [C4BB Coverage](http://hl7.org/fhir/us/carin-bb/StructureDefinition/C4BB-Coverage). Each element is checked against
terminology binding and cardinality requirements.

Elements with a required binding are validated against their bound
ValueSet. If the code/system in the element is not part of the ValueSet,
then the test will fail.

## Reference Validation
At least one instance of each external reference in elements marked as
"must support" within the resources provided by the system must resolve.
The test will attempt to read each reference found and will fail if no
read succeeds.

          )
    
          id :c4bb_v200_coverage
          run_as_group
    
          def self.metadata
            @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'coverage', 'metadata.yml'), aliases: true))
          end
      
          test from: :c4bb_v200_coverage__id_search_test
          test from: :c4bb_v200_coverage__lastUpdated_search_test
          test from: :c4bb_v200_coverage_include_Coverage_payor_search_test
          test from: :c4bb_v200_coverage_read_test
          test from: :c4bb_v200_coverage_validation_test
          test from: :c4bb_v200_coverage_must_support_test
        end
      end
    end
    