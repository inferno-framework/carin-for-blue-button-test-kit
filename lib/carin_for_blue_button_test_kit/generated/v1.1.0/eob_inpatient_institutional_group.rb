require_relative 'eob_inpatient_institutional/read_test'
    require_relative 'eob_inpatient_institutional/validation_test'
    require_relative 'eob_inpatient_institutional/must_support_test'
    require_relative 'eob_inpatient_institutional/id_search_test'
    require_relative 'eob_inpatient_institutional/patient_search_test'
    require_relative 'eob_inpatient_institutional/lastupdated_search_test'
    require_relative 'eob_inpatient_institutional/type_search_test'
    require_relative 'eob_inpatient_institutional/identifier_search_test'
    require_relative 'eob_inpatient_institutional/service_date_search_test'
    require_relative 'eob_inpatient_institutional/patient_search_test'
    require_relative 'eob_inpatient_institutional/provider_search_test'
    require_relative 'eob_inpatient_institutional/careteam_search_test'
    require_relative 'eob_inpatient_institutional/coverage_search_test'
    require_relative 'eob_inpatient_institutional/insurer_search_test'
    require_relative 'eob_inpatient_institutional/all_search_test'
    
    module CarinForBlueButtonTestKit
      module CARIN4BBV110
        class EobInpatientInstitutionalGroup < Inferno::TestGroup
          title 'ExplanationOfBenefit Inpatient Institutional Tests'
          short_description 'Verify support for the server capabilities required by the C4BB ExplanationOfBenefit Inpatient Institutional.'
          description %(
      # Background

The CARIN for Blue Button ExplanationOfBenefit Inpatient Institutional sequence verifies that the system under test is
able to provide correct responses for ExplanationOfBenefit queries. These queries
must contain resources conforming to the C4BB ExplanationOfBenefit Inpatient Institutional as
specified in the CARIN for Blue Button v1.1.0 Implementation Guide.

# Testing Methodology
## Searching
This test sequence will first perform each required search associated
with this resource. This sequence will perform searches with the
following parameters:

* _id
* patient
* _lastUpdated
* type
* identifier
* service-date

### Search Parameters
The first search uses the selected patient(s) from the prior launch
sequence. Any subsequent searches will look for its parameter values
from the results of the first search. For example, the `identifier`
search in the patient sequence is performed by looking for an existing
`Patient.identifier` from any of the resources returned in the `_id`
search. If a value cannot be found this way, the search is skipped.

### Search Validation
Inferno will retrieve up to the first 20 bundle pages of the reply for
ExplanationOfBenefit resources and save them for subsequent tests.
Each resource is then checked to see if it matches the searched
parameters in accordance with [FHIR search
guidelines](https://www.hl7.org/fhir/search.html). The test will fail,
for example, if a Patient search for `gender=male` returns a `female`
patient.


## Must Support
Each profile contains elements marked as "must support". This test
sequence expects to see each of these elements at least once. If at
least one cannot be found, the test will fail. The test will look
through the ExplanationOfBenefit resources found in the first test for these
elements.

## Profile Validation
Each resource returned from the first search is expected to conform to
the [C4BB ExplanationOfBenefit Inpatient Institutional](http://hl7.org/fhir/us/carin-bb/StructureDefinition/C4BB-ExplanationOfBenefit-Inpatient-Institutional). Each element is checked against
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
    
          id :c4bb_v110_eob_inpatient_institutional
          run_as_group
    
          def self.metadata
            @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'eob_inpatient_institutional', 'metadata.yml'), aliases: true))
          end
      
          test from: :c4bb_v110_eob_inpatient_institutional_read_test
          test from: :c4bb_v110_eob_inpatient_institutional_validation_test
          test from: :c4bb_v110_eob_inpatient_institutional_must_support_test
          test from: :c4bb_v110_eob_inpatient_institutional__id_search_test
          test from: :c4bb_v110_eob_inpatient_institutional_patient_search_test
          test from: :c4bb_v110_eob_inpatient_institutional__lastUpdated_search_test
          test from: :c4bb_v110_eob_inpatient_institutional_type_search_test
          test from: :c4bb_v110_eob_inpatient_institutional_identifier_search_test
          test from: :c4bb_v110_eob_inpatient_institutional_service_date_search_test
          test from: :c4bb_v110_eob_inpatient_institutional_include__patient_search_test
          test from: :c4bb_v110_eob_inpatient_institutional_include__provider_search_test
          test from: :c4bb_v110_eob_inpatient_institutional_include__careteam_search_test
          test from: :c4bb_v110_eob_inpatient_institutional_include__coverage_search_test
          test from: :c4bb_v110_eob_inpatient_institutional_include__insurer_search_test
          test from: :c4bb_v110_eob_inpatient_institutional_include__All_search_test
        end
      end
    end
    