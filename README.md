# CARIN IG for Blue Button® Test Kit

This is an [Inferno](https://inferno-framework.github.io/inferno-core/) test kit
for the CARIN IG for Blue Button®
[v1.1.0](http://hl7.org/fhir/us/carin-bb/STU1.1), and
[v2.0.0](http://hl7.org/fhir/us/carin-bb/STU2).

The test kit includes suites targeting the following actors from the specification:
 - CARIN IG for Blue Button® Requestor: Inferno will act as a server implementing the CARIN IG for Blue Button
 and respond to requests for patient claims data made by the client under test.
 - CARIN IG for Blue Button® Responder: Inferno will act as a client and make a series of requests to the server under test requesting CARIN for Blue Button patient claims data.

## Instructions

It is highly recommended that you use [Docker](https://www.docker.com/) to run
these tests so that you don't have to configure ruby and the HL7® FHIR®
validator service. For more information on how to run Inferno, visit [Inferno's
documentation](https://inferno-framework.github.io/inferno-core/getting-started.html)

### ONC Hosted Instance

You can run the CARIN IG for Blue Button test kit via the [ONC Inferno](https://inferno.healthit.gov/test-kits/carin-for-blue-button/) website by choosing the "CARIN IG for Blue Button Test Kit" test kit.

### Local Inferno Instance

- Clone this repo.
- Run `setup.sh` in this repo.
- Run `run.sh` in this repo.
- Navigate to `http://localhost`. The US Core test suite will be available.

## CARIN IG for Blue Button Client Test Suite 

The CARIN for Blue Button v2.0.0 Client test suite verifies the conformance of client systems to the STU2 HL7® FHIR®
[CARIN for Blue Button® Implementation Guide](http://hl7.org/fhir/us/carin-bb/STU2). These tests validate that that a
FHIR Client can play the role of a CARIN IG for Blue Button® Requestor and retrieve and use data defined by the CARIN for
Blue Button® IG.

### Sample Postman Collection

To try out these tests without a CARIN for Blue Button client implementation, you may
run them using [this Postman collection](https://github.com/inferno-framework/carin-for-blue-button-test-kit/blob/main/config/C4BB%20Client%20Search%20Tests.postman_collection.json). This Postman collection includes all of the required CARIN for Blue Button profile resource requests and required search
requests needed to pass all of the tests. Note that some requests within the collection (those suffixed with "(unsupported)") are expected to return a 400 status and OperationOutcome indicating failure due to current limitations on search parameter support.

To run the client tests against the Postman collection:
1. Start an Inferno session of the CARIN for Blue Button Client test suite.
3. Click the "Run All Tests" button in the upper right and type in "SAMPLE_TOKEN" for the `Client ID` input in the dialog that appears.
4. Click the "Submit" button. The simulated server will then be waiting for an interaction.
4. Open Postman and import the `C4BB Client Search Tests` Postman collection.
5. Send each of the requests listed under the `C4BB Client Search Tests` Postman collection and ensure a
   200 response is received along with any requested CARIN for Blue Button resources.
6. Once you have finished making requests, click the "Click here" link in the wait dialog to evaluate the requests.
7. An attestation dialog will appear asking the client to attest that it was able to process each of the 
   the resources it received. Click the first "Click here" link in the wait dialog to pass the test.

### CPCDS Reference Implementation Client

To try out these tests without a Carin for Blue Button client implementation, you may
run them using the [CPCDS Reference Implementation Client](https://github.com/carin-alliance/cpcds-client-ri).

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
5. Navigate to `localhost:3000`. Enter the Carin Client Suite FHIR endpoint URL, and then type `SAMPLE_CLIENT_ID`
   into the client ID field and `SAMPLE_CLIENT_SECRET` into the client secret field. Hit the "Connect" button.
6. This will connect the client with the test suite via SMART and the client will automatically make a request to the test suite.
7. In the Inferno Client Suite, click the "Click here" link in the wait dialog to signal the client has finished submitting requests.
8. Navigate to each Carin for Blue Button Profile test group in the left navigation sidebar, and for each test group hit the run
   icon next all the tests listed except for the last required search parameters test
   (search requests tests will not pass if ran with the CPCDS Client).

### FHIR Server Simulation for the CARIN IG for Blue Button Client Test Suite

The CARIN IG for Blue Button Client Test Suite test suite needs to be able to return responses to FHIR read and search APIs.
These responses can be complex and so the suite relies on a full FHIR server to provide
responses for it to provide back to systems under test. The test kit was written to work
with the [Inferno Reference Server](https://github.com/inferno-framework/inferno-reference-server)

- loaded with [patient 888](https://github.com/inferno-framework/inferno-reference-server/blob/main/resources/carin_bundle_patient_888.json)
- accepting bearer token `SAMPLE_TOKEN` for read access.

## TEST GENERATION
The CARIN IG for Blue Button® Test Kit has an implemeneted test generator. It
extracts necessary data elements from CARIN for Blue Button Implementation
Guide archive files and generates tests accordingly. The repo currently contains
generated test suites for IG versions 1.1.0 and 2.0.0.

To generate a test suite for a different CARIN for Blue Button IG version:
- Navigate to
  `CARIN-for-Blue-Button-Test-Kit/lib/carin_for_blue_button_test_kit/igs/`
- Drop your package.tgz file for the IG version into this folder. You may want
  to rename it before hand.
- Run the command `bundle exec rake carin4bb:generate` to run the generator.
- Run Inferno and verify that your new suite was generated and is available as
  an option

## Trademark Notice

HL7, FHIR and the FHIR [FLAME DESIGN] are the registered trademarks of Health
Level Seven International and their use does not constitute endorsement by HL7.
