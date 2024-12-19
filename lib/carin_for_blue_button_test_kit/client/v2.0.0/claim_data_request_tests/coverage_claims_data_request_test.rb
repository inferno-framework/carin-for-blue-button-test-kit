require_relative '../urls'
require_relative '../client_validation_test'

module CarinForBlueButtonTestKit
  class C4BBClientCoverageSubmitClaimsDataRequestTest < Inferno::Test
    include URLs
    include CarinForBlueButtonTestKit::ClientValidationTest

    id :coverage_claims_data_request_test
    title 'Coverage resources related to CARIN claims data are gathered'
    description %(
      This test verifies that an instance returned by requests made by the client is a Coverage resource
      that conforms to the CARIN for Blue Button [Coverage profile](https://hl7.org/fhir/us/carin-bb/STU2/StructureDefinition-C4BB-Coverage.html).
    )

    run do
      resources = previous_resource_requests(:Coverage)
      skip_if resources.nil?, 'No requests made for Coverage resources'

      assert resources.any? { |resource| resource.id == 'c4bb-Coverage' },
             'Unable to find expected resource: c4bb-Coverage'
    end
  end
end
