require_relative '../urls'
require_relative '../client_validation_test'

module CarinForBlueButtonTestKit
  class C4BBClientEOBOralSubmitClaimsDataRequestTest < Inferno::Test
    include URLs
    include CarinForBlueButtonTestKit::ClientValidationTest

    id :eob_oral_claims_data_request_test
    title 'Oral ExplanationOfBenefit resources related to CARIN claims data are gathered'
    description %(
      This test will look through all returned ExplanationOfBenefit resources for a specific expected
      ExplanationOfBenefit resource that supports the
      CARIN for Blue Button [Oral ExplanationOfBenefit profile](https://hl7.org/fhir/us/carin-bb/STU2/StructureDefinition-C4BB-ExplanationOfBenefit-Oral.html)
      on the Inferno Reference Server.
    )
    input :access_token

    verifies_requirements '170.315(g)(31)_hti-2-proposal@32'

    run do
      resources = previous_resource_requests(:ExplanationOfBenefit_Oral)
      skip_if resources.nil?, 'No requests made for ExplanationOfBenefit resources'

      assert resources.any? { |resource| resource.id == 'c4bb-EOBOral' },
             'Unable to find expected resource: c4bb-EOBOral'
    end
  end
end
