The CARIN for Blue Button v2.0.0 Client test suite verifies the conformance of client systems to the STU2 HL7® FHIR®
[CARIN for Blue Button® Implementation Guide](http://hl7.org/fhir/us/carin-bb/STU2). These tests validate that that a
FHIR Client can play the role of a CARIN IG for Blue Button® Requestor and retrieve and use data defined by the CARIN for
Blue Button® IG.

## Scope

These tests are a **DRAFT** intended to allow implementers to perform
preliminary checks of their systems against the requirements stated for CARIN IG for Blue Button client actors
and [provide feedback](https://github.com/inferno-framework/carin-for-blue-button-test-kit/issues)
on the tests. Future versions of these tests may verify other
requirements and may change the test verification logic.

## Test Methodology

For these tests Inferno simulates a FHIR server playing the role of a 
[CARIN IG for Blue Button® Responder](https://hl7.org/fhir/us/carin-bb/STU2/Conformance_Requirements.html#actors).
Inferno's simulated server contains a patient (resource id 888) that includes linked examples of all CARIN IG for
Blue Button profiles with all required and must support elements populated:
  - [Patient](https://hl7.org/fhir/us/carin-bb/STU2/StructureDefinition-C4BB-Patient.html)
  - [Coverage](https://hl7.org/fhir/us/carin-bb/STU2/StructureDefinition-C4BB-Coverage.html)
  - [Organization](https://hl7.org/fhir/us/carin-bb/STU2/StructureDefinition-C4BB-Organization.html)
  - [Practitioner](https://hl7.org/fhir/us/carin-bb/STU2/StructureDefinition-C4BB-Practitioner.html)
  - [RelatedPerson](https://hl7.org/fhir/us/carin-bb/STU2/StructureDefinition-C4BB-RelatedPerson.html)
  - [Inpatient Institutional ExplanationOfBenefit](https://hl7.org/fhir/us/carin-bb/STU2/StructureDefinition-C4BB-ExplanationOfBenefit-Inpatient-Institutional.html)
  - [Oral ExplanationOfBenefit](https://hl7.org/fhir/us/carin-bb/STU2/StructureDefinition-C4BB-ExplanationOfBenefit-Oral.html)
  - [Outpatient Institutional ExplanationOfBenefit](https://hl7.org/fhir/us/carin-bb/STU2/StructureDefinition-C4BB-ExplanationOfBenefit-Outpatient-Institutional.html)
  - [Pharmacy ExplanationOfBenefit](https://hl7.org/fhir/us/carin-bb/STU2/StructureDefinition-C4BB-ExplanationOfBenefit-Pharmacy.html)
  - [Professional NonClinician ExplanationOfBenefit](https://hl7.org/fhir/us/carin-bb/STU2/StructureDefinition-C4BB-ExplanationOfBenefit-Professional-NonClinician.html)

During execution, Inferno will wait for the client under test to issue requests and will respond to them with the requested data. Inferno will then evaluate the requests in aggregate to verify that they demonstrate that the client:
  - Retrieved instances of each [CARIN IG for Blue Button profile](https://hl7.org/fhir/us/carin-bb/STU2/artifacts.html#structures-resource-profiles)
  - Performed searches using the search parameters and search parameter combinations marked as **SHALL** within the [C4BB CapabilityStatement](https://hl7.org/fhir/us/carin-bb/STU2/CapabilityStatement-c4bb.html)
  and the [US Core Client CapabilityStatement](https://hl7.org/fhir/us/core/STU3.1.1/CapabilityStatement-us-core-client.html).
  - Processed and retained all profile instances and data elements marked as required or must support.

## Running the Tests

### Quick Start

The following input must be provided by the tester to execute
any tests in this suite:
1. *Client ID*: A Client ID that the client under test will use to connect to the test suite via SMART.
   This client ID will be sent back to the client as the `Bearer` token that the client under test will send in the 
   `Authorization` header of HTTP requests made against Inferno. Inferno uses the
   value to identify incoming requests that belong to the testing session.

The CARIN for Blue Button Patient that the client needs to request data for can be requested and searched for
with the following information:
 - **Resource ID**: 888
 - **Name**: Johnny Smith
 - **Member Identifier**: 1234-234-1243-12345678901 (system: http://inferno.healthit.gov/reference-server/r4/uniquememberidentifier)
 - **Date of Birth**: 1986-01-01
 - **Gender**: male

Once the testing starts, Inferno will wait for CARIN for Blue Button resource and search requests from the client,
return the requested CARIN resources to the client, and verify the interaction.

### Sample Execution - Postman

To try out these tests without a CARIN for Blue Button client implementation, you may
run them using [this Postman collection](https://github.com/inferno-framework/carin-for-blue-button-test-kit/blob/main/config/C4BB%20Client%20Search%20Tests.postman_collection.json). This Postman collection includes all of the required CARIN for Blue Button profile resource requests and required search
requests needed to pass all of the tests. Note that some requests within the collection (those suffixed with "(unsupported)") are expected to return a 400 status and OperationOutcome indicating failure due to current limitations on search parameter support.

To run the client tests against the Postman collection:
1. Start an Inferno session of the CARIN for Blue Button Client test suite.
3. Click the "Run All Tests" button in the upper right and type in "SAMPLE_CLIENT_ID" for the `Client ID` input in the dialog that appears.
4. Click the "Submit" button. The simulated server will then be waiting for an interaction.
4. Open Postman and import the `C4BB Client Search Tests` Postman collection.
5. Send each of the requests listed under the `C4BB Client Search Tests` Postman collection and ensure a
   200 response is received along with any requested CARIN for Blue Button resources.
6. Once you have finished making requests, click the "Click here" link in the wait dialog to evaluate the requests.
7. An attestation dialog will appear asking the client to attest that it was able to process each of the 
   the resources it received. Click the first "Click here" link in the wait dialog to pass the test.

NOTE: Inferno uses the `Bearer` token sent in the `Authorization` HTTP header 
to associate requests with sessions. If multiple concurrent sessions are configured
to use the same token, they may interfere with each other. To prevent concurrent executors
of these sample executions from disrupting your session it
is recommended, but not required, to:
1. When starting the tests, provide a random client id in the `Client ID` input.
2. A wait dialog will appear for the first test to wait for incoming requests. This window provides the bearer token Inferno expects to receive in the Authorization header of incoming requests.
3. Update the Authorization tab of the C4BB Client Search Tests collection in Postman to this provided bearer token.

## Current Limitations

This test kit is still in draft form and does not test all of the requirements and features
described in the CARIN IG For Blue Button. You can find information on the requirements
that the test kit covers and does not cover in the [Requirements Coverage](https://github.com/inferno-framework/carin-for-blue-button-test-kit/blob/main/lib/carin_for_blue_button_test_kit/requirements/generated/carin-for-blue-button-test-kit_requirements_coverage.csv)
CSV document.

Specific current limitations to highlight include:
   - Inferno's simulated CARIN server does not support all required search parameters on the ExplanationOfBenefit resource, including service-date, service-start-date, billable-period-start, type, and _include=ExplanationOfBenefit:insurer. Inferno recognizes searches made using those parameters and will give the client credit for having performed them, but will always return an OperationOutcome indicating failure. 
   - Testers must manually configure their client system to connect to a specific target patient and ingest specific curated sample CARIN data. Future versions of the tests may allow more flexibility in the patient identity and the associated data.
   - Testers must attest to their system's ability to process and retain all received information. Currently, this is implemented as a single test. Future versions of the tests may split this test out into different attestations per profile or other more fine-grained organization.
   - This test kit contains basic SMART App Launch capabilities that may not be complete. In particular, refresh tokens are not currently supported and scopes are not precise. To provide feedback and input on the design of this feature and help us prioritize improvements, submit a ticket [here](https://github.com/inferno-framework/carin-for-blue-button-test-kit/issues).