require_relative '../urls'
require_relative '../client_validation_test'

module CarinForBlueButtonTestKit
  class C4BBClientCoverageSubmitClaimsDataRequestTest < Inferno::Test
    include URLs
    include CarinForBlueButtonTestKit::ClientValidationTest

    id :coverage_claims_data_request_test
    title 'Coverage resources related to Carin claims data are gathered'
    description %(
      This test will look through all returned Coverage resources for a specific expected Carin Coverage resource.
    )
    input :access_token

    run do
      skip_if scratch[:Coverage].nil?, 'No requests made for Coverage resources'

      assert scratch[:Coverage].any? { |resource| resource.id == 'c4bb-Coverage' },
             'Unable to find expected resource: c4bb-Coverage'
    end
  end
end
