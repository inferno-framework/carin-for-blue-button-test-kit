require_relative 'explanation_of_benefit/explanation_of_benefit_read_test'
    require_relative 'explanation_of_benefit/explanation_of_benefit_validation_test'
    require_relative 'explanation_of_benefit/explanation_of_benefit_must_support_test'
    require_relative 'explanation_of_benefit/explanation_of_benefit_id_search_test'
    require_relative 'explanation_of_benefit/explanation_of_benefit_patient_search_test'
    require_relative 'explanation_of_benefit/explanation_of_benefit_lastupdated_search_test'
    require_relative 'explanation_of_benefit/explanation_of_benefit_type_search_test'
    require_relative 'explanation_of_benefit/explanation_of_benefit_identifier_search_test'
    require_relative 'explanation_of_benefit/explanation_of_benefit_service_date_search_test'
    require_relative 'explanation_of_benefit/explanation_of_benefit_explanation_of_benefit_patient_search_test'
    require_relative 'explanation_of_benefit/explanation_of_benefit_explanation_of_benefit_provider_search_test'
    require_relative 'explanation_of_benefit/explanation_of_benefit_explanation_of_benefit_careteam_search_test'
    require_relative 'explanation_of_benefit/explanation_of_benefit_explanation_of_benefit_coverage_search_test'
    require_relative 'explanation_of_benefit/explanation_of_benefit_explanation_of_benefit_insurer_search_test'
    require_relative 'explanation_of_benefit/explanation_of_benefit_explanation_of_benefit_all_search_test'
    
    module CarinForBlueButtonTestKit
      module CARIN4BBV110
        class ExplanationOfBenefitGroup < Inferno::TestGroup
          title 'Explanation Of Benefit Tests'
          short_description 'Verify support for the server capabilities required by the C4BB Explanation Of Benefit.'
          description %(
      # Background

The CARIN for Blue Button Explanation Of Benefit sequence verifies that the system under test is
able to provide correct responses for ExplanationOfBenefit queries. These queries
must contain resources conforming to the C4BB Explanation Of Benefit as
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
the [C4BB Explanation Of Benefit](http://hl7.org/fhir/us/carin-bb/StructureDefinition/C4BB-ExplanationOfBenefit). Each element is checked against
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
    
          id :c4bb_v110_explanation_of_benefit
          run_as_group
    
          def self.metadata
            @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'explanation_of_benefit', 'metadata.yml'), aliases: true))
          end
      
          test from: :c4bb_v110_explanation_of_benefit_read_test
          test from: :c4bb_v110_explanation_of_benefit_validation_test
          test from: :c4bb_v110_explanation_of_benefit_must_support_test
          test from: :c4bb_v110_explanation_of_benefit__id_search_test
          test from: :c4bb_v110_explanation_of_benefit_patient_search_test
          test from: :c4bb_v110_explanation_of_benefit__lastUpdated_search_test
          test from: :c4bb_v110_explanation_of_benefit_type_search_test
          test from: :c4bb_v110_explanation_of_benefit_identifier_search_test
          test from: :c4bb_v110_explanation_of_benefit_service_date_search_test
          test from: :c4bb_v110_explanation_of_benefit_include_ExplanationOfBenefit_patient_search_test
          test from: :c4bb_v110_explanation_of_benefit_include_ExplanationOfBenefit_provider_search_test
          test from: :c4bb_v110_explanation_of_benefit_include_ExplanationOfBenefit_careteam_search_test
          test from: :c4bb_v110_explanation_of_benefit_include_ExplanationOfBenefit_coverage_search_test
          test from: :c4bb_v110_explanation_of_benefit_include_ExplanationOfBenefit_insurer_search_test
          test from: :c4bb_v110_explanation_of_benefit_include_ExplanationOfBenefit_All_search_test
        end
      end
    end
    