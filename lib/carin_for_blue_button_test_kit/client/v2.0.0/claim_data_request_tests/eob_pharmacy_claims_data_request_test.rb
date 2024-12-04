require_relative '../urls'
require_relative '../client_validation_test'

module CarinForBlueButtonTestKit
  class C4BBClientEOBPharmacySubmitClaimsDataRequestTest < Inferno::Test
    include URLs
    include CarinForBlueButtonTestKit::ClientValidationTest

    id :eob_pharmacy_claims_data_request_test
    title 'Pharmacy ExplanationOfBenefit resources related to Carin claims data are gathered'
    description %(
      This test will look through all returned ExplanationOfBenefit resources for a specific expected
      ExplanationOfBenefit resource that supports the Carin for Blue Button Pharmacy ExplanationOfBenefit profile on
      the Inferno Reference Server.
    )
    input :access_token

    run do
      resources = previous_resource_requests(:ExplanationOfBenefit_Pharmacy)
      skip_if resources.nil?, 'No requests made for ExplanationOfBenefit resources'

      assert resources.any? { |resource| resource.id == 'c4bb-EOBPharmacy' },
             'Unable to find expected resource: c4bb-EOBPharmacyt'
    end
  end
end
