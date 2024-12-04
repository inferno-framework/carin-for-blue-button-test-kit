The CARIN for Blue Button v2.0.0 Client test suite verifies the conformance of client systems to the STU2 HL7® FHIR®
[CARIN for Blue Button® Implementation Guide](http://hl7.org/fhir/us/carin-bb/STU2). These tests are intented to validate 
CARIN IG for Blue Button Requestors, or applications that initiate a data access request to retrieve patient data.
This can be thought of as the client in a client-server interaction.

Any actor acting a FHIR Client in this IG SHALL:
  - Be able to process and retain all profile data elements that have a minimum cardinality >= 1 and/or flagged
  as Must Support as defined by that profiles StructureDefinition
  - Conform to the US Core Client Capability Statement expectations for that profiles type

## Scope

These tests are a **DRAFT** intended to allow implementers to perform
preliminary checks of their systems against the requirements stated for CARIN IG for Blue Button client actors
and [provide feedback](https://github.com/inferno-framework/subscriptions-test-kit/issues)
on the tests. Future versions of these tests may verify other
requirements and may change the test verification logic.

## Test Methodology

For these tests Inferno simulates a Carin for Blue Button server application. Inferno will wait for
the client under test to request a resource for each of the Carin for Blue Button profiles, which include the Patient,
Coverage, Inpatient Institutional ExplanationOfBenefit, Oral ExplanationOfBenefit, Outpatient Institutional ExplanationOfBenefit,
Pharmacy ExplanationOfBenefit, Professional NonClinician ExplanationOfBenefit, Organization, Practitioner, and RelatedPerson profiles.
The tests also waits for search requests to be made for each of the required searches described for each resource in the
Carin for Blue Button IG and the US Core 3.1.1 IG. For each request sent in from the client, Inferno will forward the
request to the Inferno Reference Server, where it will grab the appropriate Carin for Blue Button resources to send back to the
client. Each of these resources will contain all of the required and Must Support elements specified by the Carin for Blue Button IG
to ensure the client can process a resource containing all of these fields.

Once the client has finished submitting requests, Inferno will verify that the client has requested and received the correct
resources from the Inferno Reference server for each of the required Carin for Blue Button profiles, and it will verify that a
search request was made for each of the required searches listed for each resource. Using the interactions between Inferno and the
client under test, Inferno will verify that the client meets the obligations from the implementation guide by ensuring the client is
able to request and receive all the required resource profiles.

## Running the Tests

### Quick Start

The following input must be provided by the tester to execute
any tests in this suite:
1. *Access Token*: A `Bearer` token that the client under test will send in the 
   `Authorization` header of HTTP requests made against Inferno. Inferno uses the
   value to identify incoming requests that belong to the testing session.

Once the testing starts, Inferno will wait for Carin for Blue Button resource and search requests from the client,
forward these requests to the Inferno Reference Server, then return the Reference Server's response to
the client and verify the interaction.

### Sample Execution - Postman

To try out these tests without a Carin for Blue Button client implementation, you may
run them using the Postman collection included in the `config/presets` directory of the
[Carin for Blue Button Test Kit GitHub repository](https://github.com/inferno-framework/carin-for-blue-button-test-kit).
This Postman collection includes all of the required Carin for Blue Button profile resource requests and required search
requests needed to pass all of the tests.

To run the client tests against the Postman collection:
1. Start an Inferno session of the Carin for Blue Button Client test suite.
3. Click the "Run All Tests" button in the upper right and type in "SAMPLE_TOKEN" for the `access_token` input in the dialog that appears.
4. Click the "Submit" button. The simulated server will then be waiting for an interaction.
4. Open Postman and import the `C4BB Client Search Tests` Postman collection.
5. Send each of the requests listed under the `C4BB Client Search Tests` Postman collection and ensure a
   200 response is received along with any requested Carin for Blue Button resources.
6. Once you have finished making requests, click the "Click here" link in the wait dialog to evaluate the requests.
7. An attestation dialog will appear asking the client to attest that it was able to process each of the 
   the resources it received. Click the first "Click here" link in the wait dialog to pass the test.


### Sample Execution - CPCDS Reference Implementation Client

To try out these tests without a Carin for Blue Button client implementation, you may
run them using the [CPCDS Reference Implementation Client](https://github.com/carin-alliance/cpcds-client-ri). Use this
[forked repository](https://github.com/emichaud998/cpcds-client-ri), which been adjusted to work with this test kit.

To run the CPCDS Reference Implementation Client:
1. Follow the instructions listed [here](https://github.com/carin-alliance/cpcds-client-ri?tab=readme-ov-file#running-app-locally)
   to get the CPCDS Reference Implementation Client running locally.
      Note: If you install rails with the command `gem install rails`, you must run any of the rails commands in the README by prepending
      it with `bundle exec rails`

To run the client tests against the CPCDS Reference Implementation Client:
1. Start an Inferno session of the Carin for Blue Button Client test suite.
2. Select the *Carin CPCDS Reference Implementation Client* from the Preset dropdown in the
   upper left.
3. Click the "Wait for Claims Data and Search Requests" test group in the left navigation sidebar.
4. Click the "Run Tests" button in the upper right and click the "Submit" button in the dialog
   that appears. The simulated server will then be waiting for an interaction.
5. Navigate to `localhost:3000`. Enter the Carin Client Suite FHIR endpoint URL, and then type the Carin patient id, `888`,
   into the client secret and client id fields. Hit the "Connect" button.
6. On the next page, hit the "Display" button to make a request to the Carin Client Suite .
7. In the Inferno Client Suite, click the "Click here" link in the wait dialog to signal the client has finished submitting requests.
8. Navigate to each Carin for Blue Button Profile test group in the left navigation sidebar, and for each test group hit the run
   icon next all the tests listed except for the last required search parameters test
   (search requests tests will not pass if ran with the CPCDS Client).
7. Click the "Run Tests" button in the upper right of the final test group and an attestation dialog will appear asking the client to attest that 
   it was able to process each of the  the resources it received. Click the first "Click here" link in the wait dialog to pass the test.

NOTE: Inferno uses the `Bearer` token sent in the `Authorization` HTTP header 
to associate requests with sessions. If multiple concurrent sessions are configured
to use the same token, they may interfere with each other. To prevent concurrent executors
of these sample executions from disrupting your session it
is recommended, but not required, to change all instances of `SAMPLE_TOKEN` in the
Inferno input for the client server suite (including within the Postman request headers), 
to the same unique value so that the session will not interact with other concurrent users.