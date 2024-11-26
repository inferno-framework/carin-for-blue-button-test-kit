require_relative '../urls'
require_relative '../client_validation_test'

module CarinForBlueButtonTestKit
  class C4BBClientPractitionerSubmitClaimsDataRequestTest < Inferno::Test
    include URLs
    include CarinForBlueButtonTestKit::ClientValidationTest

    id :practitioner_claims_data_request_test
    title 'Practitioner resources related to Carin claims data are gathered'
    description %(
      This test will look through all returned Practitioner resources for a specific expected Carin Practitioner
      resource.
    )
    input :access_token

    run do
      resources = previous_resource_requests(:Practitioner)
      skip_if resources.nil?, 'No requests made for Practitioner resources'

      assert resources.any? { |resource| resource.id == 'c4bb-Practitioner' },
             'Unable to find expected resource: c4bb-Practitioner'
    end
  end
end
