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

Inferno's simulated payer endpoints require authentication using the OAuth flows
conforming either to the
- SMART Backend Services flow, or
- UDAP Business-to-Business Client Credentials flow.

When creating a test session, select the Client Security Type corresponding to an
authentication approach supported by the client. Then start by running the "Client Registration"
group which will guide you through the registration process. 
See the *Auth Configuration Details* section below for details.

Once registration is complete, run the "Verify CARIN for Blue Button Data Access" group and Inferno will 
wait for CARIN for Blue Button resource and search requests from the client, return the requested CARIN
resources to the client, and verify the interaction. The CARIN for Blue Button Patient that the client
needs to request data for can be requested and searched for with the following information:
 - **Resource ID**: 888
 - **Name**: Johnny Smith
 - **Member Identifier**: 1234-234-1243-12345678901 (system: http://inferno.healthit.gov/reference-server/r4/uniquememberidentifier)
 - **Date of Birth**: 1986-01-01
 - **Gender**: malex

### Demonstration using Postman

To try out these tests without a CARIN for Blue Button client implementation, you may
run them using [this Postman collection](https://github.com/inferno-framework/carin-for-blue-button-test-kit/blob/main/config/C4BB%20Client%20Search%20Tests.postman_collection.json). This Postman collection includes all of the required CARIN for Blue Button profile resource requests and required search
requests needed to pass all of the tests. Note that some requests within the collection (those suffixed with "(unsupported)") are expected to return a 400 status and OperationOutcome indicating failure due to current limitations on search parameter support.

To run the client tests against the Postman collection:
1. Start an Inferno session of the CARIN for Blue Button Client test suite and choose one of the SMART options for the
   Client Security Type.
1. Register and obtain and access token:
   1. In another tab, start an Inferno session for the SMART App Launch STU2.2 test suite. Select the "Demo: Run Against the SMART
      Client Suite" preset corresponding to the authentication type you chose for the CARIN Client session in step 1.
   1. Select the "Standalone Launch" group and click the "RUN TESTS" button, but don't run the tests yet.
   1. Back in the CARIN test session, select the "Client Registration" group, click the "RUN TESTS" button, and fill in the
      inputs using the values from the SMART App Tests:
      - **Client Id** from the SMART tests **Client ID** input
      - **SMART App Launch Redirect URI(s)** from the SMART app "OAuth Redirect URI" value at the top of the input box.
   1. Run the CARIN registration tests and once the wait dialog appears, confirm that the client has been set up.
   1. Select the "Verify CARIN for Blue Button Data Access" group, click the "RUN TESTS" button. In the **FHIR User Relative Reference**
      input, put `Patient/888` and click "SUBMIT".
   1. When the wait dialog appears, return to the SMART tests. Update the **FHIR Endpoint** input to use the FHIR endpoint
      displayed in the wait dialog of the CARIN tests, taking everything up to and including `/fhir`. Click "SUBMIT" and then
      click the link to authorize when instructed. The tests should complete.
   1. Find the `standalone_access_token` output in test **1.2.06** "Token exchange response body contains required information
      encoded in JSON", and copy the value, which will be a ~100 character string of letters and numbers (e.g.,
      eyJjbGllbnRfaWQiOiJzbWFydF9jbGllbnRfdGVzdF9kZW1vIiwiZXhwaXJhdGlvbiI6MTc0MzUxNDk4Mywibm9uY2UiOiJlZDI5MWIwNmZhMTE4OTc4In0).
1. Open Postman and import the `C4BB Client Search Tests` Postman collection if not already done.
1. Open the "Variables" tab of the collection, paste the `standalone_access_token` value into the "Current value" column
   for the "access_token" variable, and save the collection.
5. Send each of the requests listed under the `C4BB Client Search Tests` Postman collection and ensure a
   200 response is received along with any requested CARIN for Blue Button resources.
6. Once you have finished making requests, click the "Click here" link in the wait dialog of the CARIN client tests to
   evaluate the requests.
7. An attestation dialog will appear asking the client to attest that it was able to process each of the 
   the resources it received. Click the first "Click here" link in the wait dialog to pass the test.
8. The tests will complete and should all pass, with the possible exception of registration errors if executing on a
   non-TLS hosted server.

#### Optional Demo Modification: Tester-provided Client Id

NOTE: Inferno uses **Client Id** input and the generated bearer tokens sent in the `Authorization` HTTP header 
to associate requests with sessions. If multiple concurrent sessions are configured
to use the same token, they may interfere with each other. To prevent concurrent executors
of these sample executions from disrupting your session it is recommended, but not required, to:
1. When running the Client Registration test group, leave the **Client Id** input blank or provide your own unique or
   random value.
2. When the wait dialog appears for confirmation of client registration, note the indicated `Client Id` value and copy it
   into the **Client ID** input of the SMART tests.

#### Optional Demo Modification: UDAP Authentication

To run the demonstration using UDAP authentication to obtain an access token, replace step 2. "Register and obtain and access token"
with the following:

1. In another tab, start an Inferno session for the UDAP Security Server test suite. Select the "Demo: Run Against the UDAP Security
   Client Suite" preset
1. Select the "UDAP Authorization Code Flow" group and click the "RUN TESTS" button, but don't run the tests yet.
1. Back in the CARIN test session, select the "CARIN IG for Blue Button® v2.0.0 Client Test Suite" group,
   click the "RUN ALL TESTS" button, and fill in the following inputs using the values from the UDAP Tests:
   - **UDAP Client URI**: from the UDAP **Authorization Code JWT Issuer (iss) Claim** input
1. Run the CARIN registration tests and once the wait dialog appears, copy the "FHIR server" value and put it in the
   **FHIR Server Base URL** input of the UDAP tests.
1. Click "SUBMIT" on the UDAP tests and then click the link to authorize when instructed. The tests should complete.
1. Find the `udap_auth_code_flow_access_token` output in test **1.3.04** "Token exchange response body contains required information
   encoded in JSON", and copy the value, which will be a ~100 character string of letters and numbers (e.g.,
   eyJjbGllbnRfaWQiOiJzbWFydF9jbGllbnRfdGVzdF9kZW1vIiwiZXhwaXJhdGlvbiI6MTc0MzUxNDk4Mywibm9uY2UiOiJlZDI5MWIwNmZhMTE4OTc4In0).
1. Return to the CARIN tests and confirm that UDAP registration has been completed and then that the client has been configured
   to connect to Inferno. A third wait dialog will be displayed asking for CARIN data requests.

The tests will pass with the possible exception of some UDAP registration details.

## Input Details

### Auth Configuration Details

When running these tests there are 4 options for authentication, which also allows 
Inferno to identify which session the requests are for. The choice is made when the
session is created with the selected Client Security Type option, which determines
what details the tester needs to provide during the Client Registration tests:

- **SMART App Launch Client**: the system under test will manually register
  with Inferno and request access tokens to use when accessing FHIR endpoints
  as per the SMART App Luanch specification, which includes providing one or more
  redirect URI(s) in the **SMART App Launch Redirect URI(s)** input, and optionally,
  launch URL(s) in the **SMART App Launch URL(s)** input. Additionally, testers may provide
  a **Client Id** if they want their client assigned a specific one. Depending on the
  specific SMART flavor chosen, additional inputs for authentication may be needed:
  - **SMART App Launch Public Client**: no additional authentication inputs
  - **SMART App Launch Confidential Symmetric Client**: provide a secret using the
    **SMART Confidential Symmetric Client Secret** input.
  - **SMART App Launch Confidential Asymmetric Client**: provide a URL that resolves
    to a JWKS or a raw JWKS in JSON format using the **SMART JSON Web Key Set (JWKS)** input.
- **UDAP Authorization Code Client**: the system under test will dynamically register
  with Inferno and request access tokens used to access FHIR endpoints
  as per the UDAP specification. It requires the **UDAP Client URI** input
  to be populated with the URI that the client will use when dynamically
  registering with Inferno. This will be used to generate a client id (each
  unique UDAP Client URI will always get the same client id). All other details
  that Inferno needs will be provided as a part of the dynamic registration.

### Inputs Controlling Token Responses

Inferno's SMART simulation does not include the details needed to populate
the token response [context data](https://hl7.org/fhir/smart-app-launch/STU2.2/scopes-and-launch-context.html)
when requested by apps using scopes during the *SMART App Launch* flow. If the tested app
needs and will request these details, the tester must provide them for Inferno
to respond with using the following inputs:
- **Launch Context**: Testers can provide a JSON
  array for Inferno to use as the base for building a token response on. This can include
  keys like `"patient"` when the `launch/patient` scope will be requested. Note that when keys that Inferno
  also populates (e.g. `access_token` or `id_token`) are included, the Inferno value will be returned.
- **FHIR User Relative Reference**: Testers
  can provide a FHIR relative reference (`<resource type>/<id>`) for the FHIR user record
  to return with the `id_token` when the `openid` and `fhirUser` scopes are requested.
  If populated, ensure that the referenced resource is available in Inferno's simulated
  FHIR server so that it can be accessed.

## Current Limitations

This test kit is still in draft form and does not test all of the requirements and features
described in the CARIN IG For Blue Button. You can find information on the requirements
that the test kit covers and does not cover in the [Requirements Coverage](https://github.com/inferno-framework/carin-for-blue-button-test-kit/blob/main/lib/carin_for_blue_button_test_kit/requirements/generated/carin-for-blue-button-test-kit_requirements_coverage.csv)
CSV document.

Specific current limitations to highlight include:
   - Inferno's simulated CARIN server does not support all required search parameters on the ExplanationOfBenefit resource,
     including service-date, service-start-date, billable-period-start, type, and _include=ExplanationOfBenefit:insurer.
     Inferno recognizes searches made using those parameters and will give the client credit for having performed them, but
     will always return an OperationOutcome indicating failure. 
   - Testers must manually configure their client system to connect to a specific target patient and ingest specific curated sample
     CARIN data. Future versions of the tests may allow more flexibility in the patient identity and the associated data.
   - Testers must attest to their system's ability to process and retain all received information. Currently, this is implemented
     as a single test. Future versions of the tests may split this test out into different attestations per profile or other
     more fine-grained organization.
   - This test kit contains basic SMART App Launch and UDAP OAuth capabilities that may not be complete. In particular, Inferno will
     echo back the scopes requested by the client and will not check that they are sufficient to grant access to the data requests
     that it makes. To provide feedback and input on the design of this feature and help us prioritize improvements, submit a
     ticket [here](https://github.com/inferno-framework/carin-for-blue-button-test-kit/issues).