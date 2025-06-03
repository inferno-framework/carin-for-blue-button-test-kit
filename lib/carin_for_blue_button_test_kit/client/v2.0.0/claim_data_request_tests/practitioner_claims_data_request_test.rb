# frozen_string_literal: true

require_relative '../urls'
require_relative '../client_validation_test'

module CarinForBlueButtonTestKit
  class C4BBClientPractitionerSubmitClaimsDataRequestTest < Inferno::Test
    include URLs
    include CarinForBlueButtonTestKit::ClientValidationTest

    id :practitioner_claims_data_request_test
    title 'Practitioner resources related to CARIN claims data are gathered'
    description %(
      This test verifies that an instance returned by requests made by the client is a Practitioner resource
      that conforms to the CARIN for Blue Button [Practitioner profile](https://hl7.org/fhir/us/carin-bb/STU2/StructureDefinition-C4BB-Practitioner.html).
    )

    run do
      resources = previous_resource_requests(:Practitioner)
      skip_if resources.nil?, 'No requests made for Practitioner resources'

      assert resources.any? { |resource| resource.id == 'c4bb-Practitioner' },
             'Unable to find expected resource: c4bb-Practitioner'
    end
  end
end
