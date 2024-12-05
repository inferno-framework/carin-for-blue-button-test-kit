require_relative '../urls'
require_relative '../client_validation_test'

module CarinForBlueButtonTestKit
  class C4BBClientOrganizationSubmitClaimsDataRequestTest < Inferno::Test
    include URLs
    include CarinForBlueButtonTestKit::ClientValidationTest

    id :organization_claims_data_request_test
    title 'Organization resources related to CARIN claims data are gathered'
    description %(
      This test will look through all returned Organization resources for a specific expected Organization
      resource that supports the CARIN for Blue Button [Organization profile](https://hl7.org/fhir/us/carin-bb/STU2/StructureDefinition-C4BB-Organization.html)
      on the Inferno Reference Server.
    )
    input :access_token

    verifies_requirements '170.315(g)(31)_hti-2-proposal@32'

    run do
      resources = previous_resource_requests(:Organization)
      skip_if resources.nil?, 'No requests made for Organization resources'

      assert resources.any? { |resource|
        resource.id == 'c4bb-Organization'
      }, 'Unable to find expected resource: c4bb-Organization'
    end
  end
end
