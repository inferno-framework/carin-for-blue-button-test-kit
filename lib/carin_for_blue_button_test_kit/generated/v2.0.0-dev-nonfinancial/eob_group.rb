# frozen_string_literal: true

require_relative 'eob/patient_search_test'
require_relative 'eob/id_search_test'
require_relative 'eob/lastupdated_search_test'
require_relative 'eob/type_search_test'
require_relative 'eob/identifier_search_test'
require_relative 'eob/service_date_search_test'
require_relative 'eob/service_start_date_search_test'
require_relative 'eob/billable_period_start_search_test'
require_relative 'eob/incl_patient_search_test'
require_relative 'eob/incl_provider_search_test'
require_relative 'eob/incl_careteam_search_test'
require_relative 'eob/incl_coverage_search_test'
require_relative 'eob/incl_insurer_search_test'
require_relative 'eob/incl_payee_search_test'
require_relative 'eob/incl_all_search_test'
require_relative 'eob/read_test'
require_relative 'eob/validation_test'
require_relative 'eob/must_support_test'
require_relative 'eob_inpatient_institutional/validation_test'
require_relative 'eob_inpatient_institutional/must_support_test'
require_relative 'eob_inpatient_institutional_non_financial/validation_test'
require_relative 'eob_inpatient_institutional_non_financial/must_support_test'
require_relative 'eob_outpatient_institutional/validation_test'
require_relative 'eob_outpatient_institutional/must_support_test'
require_relative 'eob_outpatient_institutional_non_financial/validation_test'
require_relative 'eob_outpatient_institutional_non_financial/must_support_test'
require_relative 'eob_oral/validation_test'
require_relative 'eob_oral/must_support_test'
require_relative 'eob_oral_non_financial/validation_test'
require_relative 'eob_oral_non_financial/must_support_test'
require_relative 'eob_pharmacy/validation_test'
require_relative 'eob_pharmacy/must_support_test'
require_relative 'eob_pharmacy_non_financial/validation_test'
require_relative 'eob_pharmacy_non_financial/must_support_test'
require_relative 'eob_professional_non_clinician/validation_test'
require_relative 'eob_professional_non_clinician/must_support_test'
require_relative 'eob_professional_non_clinician_non_financial/validation_test'
require_relative 'eob_professional_non_clinician_non_financial/must_support_test'

module CarinForBlueButtonTestKit
  module CARIN4BBV200DEVNONFINANCIAL
    class EobGroup < Inferno::TestGroup
      title 'Explanation Of Benefit Tests'
      short_description 'Verify support for the server capabilities required by the C4BB Explanation Of Benefit.'
      description %(
# Background

The CARIN for Blue Button Explanation Of Benefit sequence verifies that the system under test is
able to provide correct responses for ExplanationOfBenefit queries. These queries
must contain resources conforming to the C4BB Explanation Of Benefit as
specified in the CARIN for Blue Button v2.0.0-dev-nonfinancial Implementation Guide.

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
* service-start-date
* billable-period-start

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
      verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@95', 'hl7.fhir.us.carin-bb_2.0.0@103'

      id :c4bb_v200devnonfinancial_eob
      run_as_group

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'eob', 'metadata.yml'),
                                                                  aliases: true))
      end

      test from: :c4bb_v200devnonfinancial_eob_patient_search_test
      test from: :c4bb_v200devnonfinancial_eob__id_search_test
      test from: :c4bb_v200devnonfinancial_eob__lastUpdated_search_test
      test from: :c4bb_v200devnonfinancial_eob_type_search_test
      test from: :c4bb_v200devnonfinancial_eob_identifier_search_test
      test from: :c4bb_v200devnonfinancial_eob_service_date_search_test
      test from: :c4bb_v200devnonfinancial_eob_service_start_date_search_test
      test from: :c4bb_v200devnonfinancial_eob_billable_period_start_search_test
      test from: :c4bb_v200devnonfinancial_eob_include_ExplanationOfBenefit_patient_search_test
      test from: :c4bb_v200devnonfinancial_eob_include_ExplanationOfBenefit_provider_search_test
      test from: :c4bb_v200devnonfinancial_eob_include_ExplanationOfBenefit_careteam_search_test
      test from: :c4bb_v200devnonfinancial_eob_include_ExplanationOfBenefit_coverage_search_test
      test from: :c4bb_v200devnonfinancial_eob_include_ExplanationOfBenefit_insurer_search_test
      test from: :c4bb_v200devnonfinancial_eob_include_ExplanationOfBenefit_payee_search_test
      test from: :c4bb_v200devnonfinancial_eob_include_ExplanationOfBenefit_All_search_test
      test from: :c4bb_v200devnonfinancial_eob_read_test
      test from: :c4bb_v200devnonfinancial_eob_validation_test
      test from: :c4bb_v200devnonfinancial_eob_must_support_test
      test from: :c4bb_v200devnonfinancial_eob_inpatient_institutional_validation_test
      test from: :c4bb_v200devnonfinancial_eob_inpatient_institutional_must_support_test
      test from: :c4bb_v200devnonfinancial_eob_inpatient_institutional_non_financial_validation_test
      test from: :c4bb_v200devnonfinancial_eob_inpatient_institutional_non_financial_must_support_test
      test from: :c4bb_v200devnonfinancial_eob_outpatient_institutional_validation_test
      test from: :c4bb_v200devnonfinancial_eob_outpatient_institutional_must_support_test
      test from: :c4bb_v200devnonfinancial_eob_outpatient_institutional_non_financial_validation_test
      test from: :c4bb_v200devnonfinancial_eob_outpatient_institutional_non_financial_must_support_test
      test from: :c4bb_v200devnonfinancial_eob_oral_validation_test
      test from: :c4bb_v200devnonfinancial_eob_oral_must_support_test
      test from: :c4bb_v200devnonfinancial_eob_oral_non_financial_validation_test
      test from: :c4bb_v200devnonfinancial_eob_oral_non_financial_must_support_test
      test from: :c4bb_v200devnonfinancial_eob_pharmacy_validation_test
      test from: :c4bb_v200devnonfinancial_eob_pharmacy_must_support_test
      test from: :c4bb_v200devnonfinancial_eob_pharmacy_non_financial_validation_test
      test from: :c4bb_v200devnonfinancial_eob_pharmacy_non_financial_must_support_test
      test from: :c4bb_v200devnonfinancial_eob_professional_non_clinician_validation_test
      test from: :c4bb_v200devnonfinancial_eob_professional_non_clinician_must_support_test
      test from: :c4bb_v200devnonfinancial_eob_professional_non_clinician_non_financial_validation_test
      test from: :c4bb_v200devnonfinancial_eob_professional_non_clinician_non_financial_must_support_test
    end
  end
end
