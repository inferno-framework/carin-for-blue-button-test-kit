require_relative '../urls'
module CarinForBlueButtonTestKit
  class C4BBClientSubmitRequiredSearchesTest < Inferno::Test
    include URLs

    id :initial_wait_test_required_searches
    title 'Client makes required search parameter requests'
    description %(
      This test will receive search requests until the user confirms they are done.
    )
    input :access_token
    config options: { accepts_multiple_requests: true }

    run do
      wait(
        identifier: access_token,
        message: %(
          Access Token: #{access_token} \n
          Submit Carin requests via the following method:
          * Single Resource API: `#{submit_url}?:search_params`, with `:endpoint` replaced with the endpoint you want
          to reach and `:search_params` replaced with the search parameters for the request.


          The following search parameters are required for each resource type:
            * Patient: `888`
              * _id
            * Coverage: `c4bb-Coverage`
              * _id
            * Organization: `c4bb-Organization`
              * _id
            * Practitioner: `c4bb-Practitioner`
              * _id
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

          Note: If you already made requests with required search params for the last group of tests, you do not need
          to make them again

          [Click here](#{resume_claims_data_url}?token=#{access_token}) when done.
        ),
        timeout: 900
      )
    end
  end
end
