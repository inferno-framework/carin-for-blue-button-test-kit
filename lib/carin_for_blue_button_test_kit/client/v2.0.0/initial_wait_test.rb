require_relative 'urls'
module CarinForBlueButtonTestKit
  class C4BBClientInitialWaitTest < Inferno::Test
    include URLs

    id :c4bb_v200_initial_wait_test
    title 'Client makes claims data and required search parameter requests'
    description %(
      This test will receive claims data requests and search requests until the user confirms they are done.
    )
    input :client_id,
          title: 'Client ID',
          description: %(
            Enter the client ID you will use to connect to this CARIN server via a SMART launch.
          )

    config options: { accepts_multiple_requests: true }

    def example_client_jwt_payload_part
      Base64.strict_encode64({ inferno_client_id: client_id }.to_json).delete('=')
    end

    run do
      wait(
        identifier: client_id,
        message: %(
          ### SMART App Launch

          You may connect to the Inferno CARIN client test server using the [SMART Backend Services](https://hl7.org/fhir/smart-app-launch/STU2/backend-services.html)
          Authorization protocol. Perform the following steps:
            1. Retrieve .well-known/smart-configuration: `#{smart_configuration_url}`
            2. Obtain access token: `#{token_url}`
            3. Access FHIR API

          ### Request Identification

          In order to identify requests for this session, Inferno will look for
          an `Authorization` header with value:

          ```
          Bearer eyJhbGciOiJub25lIn0.#{example_client_jwt_payload_part}.
          ```

          ### FHIR API

          Submit CARIN requests via the following method:
          * Single Resource API: `#{submit_url}?:search_params`, with `:endpoint` replaced with the endpoint you want
          to reach and `:search_params` replaced with the search parameters for the request.

          The following CARIN resources can be accessed on the Inferno Reference Server with the following IDs, and
          the following search parameters are required for each resource type:

            * Patient: `888`
              * _id
              * birthdate
              * family
              * gender
              * given
              * identifier
              * name
              * birthdate+family
              * family+gender
              * birthdate+name
              * gender+name
            * Coverage: `c4bb-Coverage`
              * _id
              * patient
            * Organization: `c4bb-Organization`
              * _id
              * name
              * address
            * Practitioner: `c4bb-Practitioner`
              * _id
              * name
              * identifier
            * RelatedPerson: `c4bb-RelatedPerson`
              * _id
            * ExplanationOfBenefit: `c4bb-EOBInpatient`, `c4bb-EOBOutpatient`, `c4bb-EOBOral`, `c4bb-EOBPharmacy`,
            `c4bb-EOBProfessional`
              * _id
              * patient
              * identifier
              * _lastUpdated
              * service-date
              * service-start-date
              * billable-period-start
              * type
              * _include:
                * ExplanationOfBenefit:patient
                * ExplanationOfBenefit:provider
                * ExplanationOfBenefit:care-team
                * ExplanationOfBenefit:coverage
                * ExplanationOfBenefit:insurer
                * ExplanationOfBenefit:payee
                * ExplanationOfBenefit:*


          [Click here](#{resume_claims_data_url}?test_run_identifier=#{client_id}) when done.
        ),
        timeout: 900
      )
    end
  end
end
