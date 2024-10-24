require_relative '../urls'
require_relative '../client_validation_test'

module CarinForBlueButtonTestKit
  class C4BBClientEOBInpatientSubmitClaimsDataRequestTest < Inferno::Test
    include URLs
    include CarinForBlueButtonTestKit::ClientValidationTest

    id :eob_inpatient_claims_data_request_test
    title 'Inpatient Institutional ExplanationOfBenefit resources related to Carin claims data are gathered'
    description %(
      This test will look through all returned Inpatient Institutional ExplanationOfBenefit resources for a specific
      expected Carin ExplanationOfBenefit resource on the Inferno Reference Server.
    )
    input :access_token

    run do
      skip_if scratch[:ExplanationOfBenefit_Inpatient_Institutional].nil?,
              'No requests made for ExplanationOfBenefit resources'

      assert scratch[:ExplanationOfBenefit_Inpatient_Institutional].any? { |resource|
        resource.id == 'c4bb-EOBInpatient'
      },
             'Unable to find expected resource: c4bb-EOBInpatient'
    end
  end
end
