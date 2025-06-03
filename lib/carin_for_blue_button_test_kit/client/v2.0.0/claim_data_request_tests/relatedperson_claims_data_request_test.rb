# frozen_string_literal: true

require_relative '../urls'
require_relative '../client_validation_test'

module CarinForBlueButtonTestKit
  class C4BBClientRelatedPersonSubmitClaimsDataRequestTest < Inferno::Test
    include URLs
    include CarinForBlueButtonTestKit::ClientValidationTest

    id :relatedperson_claims_data_request_test
    title 'RelatedPerson resources related to CARIN claims data are gathered'
    description %(
      This test verifies that an instance returned by requests made by the client is a RelatedPerson resource
      that conforms to the CARIN for Blue Button [RelatedPerson profile](https://hl7.org/fhir/us/carin-bb/STU2/StructureDefinition-C4BB-RelatedPerson.html).
    )

    run do
      resources = previous_resource_requests(:RelatedPerson)
      skip_if resources.nil?, 'No requests made for RelatedPerson resources'

      assert resources.any? { |resource| resource.id == 'c4bb-RelatedPerson' },
             'Unable to find expected resource: c4bb-RelatedPerson'
    end
  end
end
