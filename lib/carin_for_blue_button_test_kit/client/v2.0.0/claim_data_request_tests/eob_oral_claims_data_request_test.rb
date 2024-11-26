require_relative '../urls'
require_relative '../client_validation_test'

module CarinForBlueButtonTestKit
  class C4BBClientEOBOralSubmitClaimsDataRequestTest < Inferno::Test
    include URLs
    include CarinForBlueButtonTestKit::ClientValidationTest

    id :eob_oral_claims_data_request_test
    title 'Oral ExplanationOfBenefit resources related to Carin claims data are gathered'
    description %(
      This test will look through all returned Oral ExplanationOfBenefit resources for a specific expected Carin
      ExplanationOfBenefit resource on the Inferno Reference Server.
    )
    input :access_token

    run do
      resources = previous_resource_requests(:ExplanationOfBenefit_Oral)
      skip_if resources.nil?, 'No requests made for ExplanationOfBenefit resources'

      assert resources.any? { |resource| resource.id == 'c4bb-EOBOral' },
             'Unable to find expected resource: c4bb-EOBOral'
    end
  end
end
