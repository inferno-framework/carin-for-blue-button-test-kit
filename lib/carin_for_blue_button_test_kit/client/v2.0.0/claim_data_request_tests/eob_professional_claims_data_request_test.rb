require_relative '../urls'
require_relative '../client_validation_test'

module CarinForBlueButtonTestKit
  class C4BBClientEOBProfessionalSubmitClaimsDataRequestTest < Inferno::Test
    include URLs
    include CarinForBlueButtonTestKit::ClientValidationTest

    id :eob_professional_claims_data_request_test
    title 'Professional NonClinician ExplanationOfBenefit resources related to CARIN claims data are gathered'
    description %(
      This test will look through all returned ExplanationOfBenefit resources for a specific expected
      ExplanationOfBenefit resource that supports the CARIN for Blue Button
      [Professional NonClinician ExplanationOfBenefit profile](https://hl7.org/fhir/us/carin-bb/STU2/StructureDefinition-C4BB-ExplanationOfBenefit-Professional-NonClinician.html)
      on the Inferno Reference Server.
    )
    input :access_token

    run do
      resources = previous_resource_requests(:ExplanationOfBenefit_Professional_NonClinician)
      skip_if resources.nil?,
              'No requests made for ExplanationOfBenefit resources'

      assert resources.any? { |resource|
        resource.id == 'c4bb-EOBProfessional'
      }, 'Unable to find expected resource: c4bb-EOBProfessional'
    end
  end
end
