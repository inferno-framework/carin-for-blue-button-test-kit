# frozen_string_literal: true

require_relative 'practitioner/id_search_test'
require_relative 'practitioner/lastupdated_search_test'
require_relative 'practitioner/read_test'
require_relative 'practitioner/validation_test'
require_relative 'practitioner/must_support_test'

module CarinForBlueButtonTestKit
  module CARIN4BBV200DEVNONFINANCIAL
    class PractitionerGroup < Inferno::TestGroup
      title 'Practitioner Tests'
      short_description 'Verify support for the server capabilities required by the C4BB Practitioner.'
      description %(
# Background

The CARIN for Blue Button Practitioner sequence verifies that the system under test is
able to provide correct responses for Practitioner queries. These queries
must contain resources conforming to the C4BB Practitioner as
specified in the CARIN for Blue Button v2.0.0-dev-nonfinancial Implementation Guide.

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
Practitioner resources and save them for subsequent tests.
Each resource is then checked to see if it matches the searched
parameters in accordance with [FHIR search
guidelines](https://www.hl7.org/fhir/search.html). The test will fail,
for example, if a Patient search for `gender=male` returns a `female`
patient.


## Must Support
Each profile contains elements marked as "must support". This test
sequence expects to see each of these elements at least once. If at
least one cannot be found, the test will fail. The test will look
through the Practitioner resources found in the first test for these
elements.

## Profile Validation
Each resource returned from the first search is expected to conform to
the [C4BB Practitioner](http://hl7.org/fhir/us/carin-bb/StructureDefinition/C4BB-Practitioner). Each element is checked against
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
      verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@95'

      id :c4bb_v200devnonfinancial_practitioner
      run_as_group
      optional

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'practitioner', 'metadata.yml'),
                                                                  aliases: true))
      end

      test from: :c4bb_v200devnonfinancial_practitioner__id_search_test
      test from: :c4bb_v200devnonfinancial_practitioner__lastUpdated_search_test
      test from: :c4bb_v200devnonfinancial_practitioner_read_test
      test from: :c4bb_v200devnonfinancial_practitioner_validation_test
      test from: :c4bb_v200devnonfinancial_practitioner_must_support_test
    end
  end
end
