require_relative '../urls'
require_relative '../client_validation_test'

module CarinForBlueButtonTestKit
  class C4BBClientPractitionerSubmitClaimsDataRequestTest < Inferno::Test
    include URLs
    include CarinForBlueButtonTestKit::ClientValidationTest

    id :practitioner_claims_data_request_test
    title 'Practitioner resources related to CARIN claims data are gathered'
    description %(
      This test will look through all returned Practitioner resources for a specific expected Practitioner
      resource that supports the CARIN for Blue Button [Practitioner profile](https://hl7.org/fhir/us/carin-bb/STU2/StructureDefinition-C4BB-Practitioner.html)
      on the Inferno Reference Server.
    )
    input :access_token

    verifies_requirements '170.315(g)(31)_hti-2-proposal@32'

    run do
      resources = previous_resource_requests(:Practitioner)
      skip_if resources.nil?, 'No requests made for Practitioner resources'

      assert resources.any? { |resource| resource.id == 'c4bb-Practitioner' },
             'Unable to find expected resource: c4bb-Practitioner'
    end
  end
end
