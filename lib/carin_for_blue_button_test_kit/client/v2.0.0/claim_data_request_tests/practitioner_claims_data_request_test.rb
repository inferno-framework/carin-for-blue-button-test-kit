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
      skip_if scratch[:Practitioner].nil?, 'No requests made for Practitioner resources'

      assert scratch[:Practitioner].any? { |resource| resource.id == 'c4bb-Practitioner' },
             'Unable to find expected resource: c4bb-Practitioner'
    end
  end
end
