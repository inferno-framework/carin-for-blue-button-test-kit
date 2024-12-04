require_relative '../urls'
require_relative '../client_validation_test'

module CarinForBlueButtonTestKit
  class C4BBClientOrganizationSubmitClaimsDataRequestTest < Inferno::Test
    include URLs
    include CarinForBlueButtonTestKit::ClientValidationTest

    id :organization_claims_data_request_test
    title 'Organization resources related to Carin claims data are gathered'
    description %(
      This test will look through all returned Organization resources for a specific expected Organization
      resource that supports the Carin for Blue Button Organization profile on the Inferno Reference Server.
    )
    input :access_token

    run do
      resources = previous_resource_requests(:Organization)
      skip_if resources.nil?, 'No requests made for Organization resources'

      assert resources.any? { |resource|
        resource.id == 'c4bb-Organization'
      }, 'Unable to find expected resource: c4bb-Organization'
    end
  end
end
