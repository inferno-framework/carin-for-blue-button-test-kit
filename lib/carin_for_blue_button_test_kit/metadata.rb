require_relative 'version'

module CarinForBlueButtonTestKit
  class Metadata < Inferno::TestKit
    id :carin_for_blue_button_test_kit
    title 'CARIN IG for Blue Button Test Kit'
    description <<~DESCRIPTION
      The Carin IG for Blue Button Test Kit validates the conformance of server
      and client implementations to the [CARIN IG for Blue
      Button](https://hl7.org/fhir/us/carin-bb/) including versions:
      - [**v1.1.0**](http://hl7.org/fhir/us/carin-bb/STU1.1) (server tests only)
      - [**v2.0.0**](http://hl7.org/fhir/us/carin-bb/STU2) (server and client tests)
      - **Non-financial Proposal** (server tests only)

      <!-- break -->

      This test kit is built using the [Inferno Framework](https://inferno-framework.github.io/inferno-core/). The Inferno Framework is
      designed for reuse and aims to make it easier to build test kits for any
      FHIR-based data exchange.

      ## Status

      These tests are intended to allow CARIN IG for Blue Button server implementers to perform checks of their server against CARIN IG for Blue Button requrirements. Future versions of these tests may validate other requirements and may change how these are tested.

      For more details on the specific validations performed as part of testing the following requirements, see the test descriptions within the test suites.

      ### Server Tests

      The server suites currently test the following requirements:
      - SMART on FHIR Discovery
      - SMART App Launch Protocol's standalone launch sequence
      - Support for Capability Statement
      - Support for Must Support Elements
      - Profile Validation
      - Reference Validation
      - Searching on ExplanationofBenefit Resource

      ### Client Tests

      The client suite currently tests that clients are able to
      - Fetch instances conformant to each FHIR profile defined in the CARIN IG.
      - Perform searches using each of the required search parameters.
      - Correctly process instances containing populated examples of all must support elements.

      You can find additional information on the IG requirements that the client test suite covers
      and does not cover in the [Requirements Coverage](https://github.com/inferno-framework/carin-for-blue-button-test-kit/blob/main/lib/carin_for_blue_button_test_kit/requirements/generated/carin-for-blue-button-test-kit_requirements_coverage.csv)
      CSV document.

      Specific known limitations of the client tests include:
      - Inferno's simulated CARIN server does not support all required search parameters on the ExplanationOfBenefit resource, including service-date, service-start-date, billable-period-start, type, and _include=ExplanationOfBenefit:insurer. Inferno recognizes searches made using those parameters and will give the client credit for having performed them but will always return an OperationOutcome indicating failure.
      - Testers must manually configure their client system to connect to a specific target patient and ingest specific curated sample CARIN data. Future versions of the tests may allow more flexibility in the patient identity and the associated data.
      - Testers must attest to their system's ability to process and retain all received information. Currently, this is implemented as a single test. Future versions of the tests may split this test out into different attestations per profile or other more fine-grained organization.

      ## Repository

      The Carin IG for Blue Button Test Kit GitHub repository can be [found here](https://github.com/inferno-framework/carin-for-blue-button-test-kit).

      ## Providing Feedback and Reporting Issues

      Please report any issues with this set of tests in the [issues section](https://github.com/inferno-framework/carin-for-blue-button-test-kit/issues) of the repository.
    DESCRIPTION
    suite_ids [:c4bb_v110, :c4bb_v200, :c4bb_v200_client, :c4bb_v200devnonfinancial]
    tags ['CARIN']
    last_updated LAST_UPDATED
    version VERSION
    maturity 'Medium'
    authors ['Inferno Team']
    repo 'https://github.com/inferno-framework/carin-for-blue-button-test-kit'
  end
end
