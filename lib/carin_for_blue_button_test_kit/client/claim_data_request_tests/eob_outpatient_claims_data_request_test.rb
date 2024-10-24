require_relative '../urls'
require_relative '../client_validation_test'

module CarinForBlueButtonTestKit
  class C4BBClientEOBOutpatientSubmitClaimsDataRequestTest < Inferno::Test
    include URLs
    include CarinForBlueButtonTestKit::ClientValidationTest

    id :eob_outpatient_claims_data_request_test
    title 'Outpatient Institutional ExplanationOfBenefit resources related to Carin claims data are gathered'
    description %(
      This test will look through all returned Outpatient Institutional ExplanationOfBenefit resources for a specific
      expected Carin ExplanationOfBenefit resource on the Inferno Reference Server.
    )
    input :access_token

    run do
      skip_if scratch[:ExplanationOfBenefit_Outpatient_Institutional].nil?,
              'No requests made for ExplanationOfBenefit resources'

      assert scratch[:ExplanationOfBenefit_Outpatient_Institutional].any? { |resource|
        resource.id == 'c4bb-EOBOutpatient'
      },
             'Unable to find expected resource: c4bb-EOBOutpatient'
    end
  end
end
