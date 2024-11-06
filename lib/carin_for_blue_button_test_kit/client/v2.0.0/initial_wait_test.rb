require_relative 'urls'
module CarinForBlueButtonTestKit
  class C4BBClientSubmitMustSupportTest < Inferno::Test
    include URLs

    id :initial_wait_test
    title 'Client makes claims data requests'
    description %(
      This test will receive claims data requests until the user confirms they are done.
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

          The following Carin resources can be accessed on the Inferno Reference Server with the following IDs:
            * Patient: `888`
            * Coverage: `c4bb-Coverage`
            * Organization: `c4bb-Organization`
            * Practitioner: `c4bb-Practitioner`
            * RelatedPerson: `c4bb-RelatedPerson`
            * ExplanationOfBenefit Inpatient Institutional: `c4bb-EOBInpatient`
            * ExplanationOfBenefit Outpatient Institutional: `c4bb-EOBOutpatient`
            * ExplanationOfBenefit Oral: `c4bb-EOBOral`
            * ExplanationOfBenefit Pharmacy: `c4bb-EOBPharmacy`
            * ExplanationOfBenefit Professional NonClinician: `c4bb-EOBProfessional`

          [Click here](#{resume_claims_data_url}?token=#{access_token}) when done.
        ),
        timeout: 900
      )
    end
  end
end
