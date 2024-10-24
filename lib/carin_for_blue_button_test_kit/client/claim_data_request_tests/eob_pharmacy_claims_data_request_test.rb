require_relative '../urls'
require_relative '../client_validation_test'

module CarinForBlueButtonTestKit
  class C4BBClientEOBPharmacySubmitClaimsDataRequestTest < Inferno::Test
    include URLs
    include CarinForBlueButtonTestKit::ClientValidationTest

    id :eob_pharmacy_claims_data_request_test
    title 'Pharmacy ExplanationOfBenefit resources related to Carin claims data are gathered'
    description %(
      This test will look through all returned Pharmacy ExplanationOfBenefit resources for a specific expected Carin
      ExplanationOfBenefit resource on the Inferno Reference Server.
    )
    input :access_token

    run do
      skip_if scratch[:ExplanationOfBenefit_Pharmacy].nil?, 'No requests made for ExplanationOfBenefit resources'

      assert scratch[:ExplanationOfBenefit_Pharmacy].any? { |resource| resource.id == 'c4bb-EOBPharmacy' },
             'Unable to find expected resource: c4bb-EOBPharmacyt'
    end
  end
end
