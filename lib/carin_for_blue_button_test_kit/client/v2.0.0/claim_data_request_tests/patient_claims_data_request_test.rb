require_relative '../urls'
require_relative '../client_validation_test'

module CarinForBlueButtonTestKit
  class C4BBClientPatientSubmitClaimsDataRequestTest < Inferno::Test
    include URLs
    include CarinForBlueButtonTestKit::ClientValidationTest

    id :patient_claims_data_request_test
    title 'Patient resources related to the patient matched are gathered'
    description %(
      This test will look through all returned Patient resources for a specific expected Carin Patient resource.
    )
    input :access_token

    run do
      skip_if scratch[:Patient].nil?, 'No requests made for Patient resources'

      assert scratch[:Patient].any? { |resource| resource.id == '888' }, 'Unable to find expected resource: 888'
    end
  end
end