require_relative '../urls'
require_relative '../client_validation_test'

module CarinForBlueButtonTestKit
  class C4BBClientEOBProfessionalSubmitClaimsDataRequestTest < Inferno::Test
    include URLs
    include CarinForBlueButtonTestKit::ClientValidationTest

    id :eob_professional_claims_data_request_test
    title 'Professional NonClinician ExplanationOfBenefit resources related to Carin claims data are gathered'
    description %(
      This test will look through all returned Professional NonClinician ExplanationOfBenefit resources for a specific
      expected Carin ExplanationOfBenefit resource on the Inferno Reference Server.
    )
    input :access_token

    run do
      skip_if scratch[:ExplanationOfBenefit_Professional_NonClinician].nil?,
              'No requests made for ExplanationOfBenefit resources'

      assert scratch[:ExplanationOfBenefit_Professional_NonClinician].any? { |resource|
        resource.id == 'c4bb-EOBProfessional'
      }, 'Unable to find expected resource: c4bb-EOBProfessional'
    end
  end
end
