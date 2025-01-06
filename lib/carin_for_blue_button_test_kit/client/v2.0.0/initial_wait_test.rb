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
            Enter the client ID you will use to connect to this CARIN server via a SMART launch. If you wish to send
            requests without performing a SMART launch, encode this client id in a JWT and send as the Bearer token.
          )

    config options: { accepts_multiple_requests: true }

    run do
      wait(
        identifier: client_id,
        message: %(
          Access Token: #{client_id} \n
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
