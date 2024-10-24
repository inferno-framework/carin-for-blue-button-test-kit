require_relative '../urls'
require_relative '../client_validation_test'

module CarinForBlueButtonTestKit
  class C4BBClientOrganizationSubmitClaimsDataRequestTest < Inferno::Test
    include URLs
    include CarinForBlueButtonTestKit::ClientValidationTest

    id :organization_claims_data_request_test
    title 'Organization resources related to Carin claims data are gathered'
    description %(
      This test will look through all returned Organization resources for a specific expected Carin Organization
      resource.
    )
    input :access_token

    run do
      skip_if scratch[:Organization].nil?, 'No requests made for Organization resources'

      assert scratch[:Organization].any? { |resource|
        resource.id == 'c4bb-Organization'
      }, 'Unable to find expected resource: c4bb-Organization'
    end
  end
end
