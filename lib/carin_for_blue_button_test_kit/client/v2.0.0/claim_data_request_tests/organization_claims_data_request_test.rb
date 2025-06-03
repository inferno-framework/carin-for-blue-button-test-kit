# frozen_string_literal: true

require_relative '../urls'
require_relative '../client_validation_test'

module CarinForBlueButtonTestKit
  class C4BBClientOrganizationSubmitClaimsDataRequestTest < Inferno::Test
    include URLs
    include CarinForBlueButtonTestKit::ClientValidationTest

    id :organization_claims_data_request_test
    title 'Organization resources related to CARIN claims data are gathered'
    description %(
      This test verifies that an instance returned by requests made by the client is an Organization resource
      that conforms to the CARIN for Blue Button [Organization profile](https://hl7.org/fhir/us/carin-bb/STU2/StructureDefinition-C4BB-Organization.html).
    )

    run do
      resources = previous_resource_requests(:Organization)
      skip_if resources.nil?, 'No requests made for Organization resources'

      assert resources.any? { |resource|
        resource.id == 'c4bb-Organization'
      }, 'Unable to find expected resource: c4bb-Organization'
    end
  end
end
