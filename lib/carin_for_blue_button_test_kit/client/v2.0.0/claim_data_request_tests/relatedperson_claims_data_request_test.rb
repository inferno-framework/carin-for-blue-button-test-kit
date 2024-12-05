require_relative '../urls'
require_relative '../client_validation_test'

module CarinForBlueButtonTestKit
  class C4BBClientRelatedPersonSubmitClaimsDataRequestTest < Inferno::Test
    include URLs
    include CarinForBlueButtonTestKit::ClientValidationTest

    id :relatedperson_claims_data_request_test
    title 'RelatedPerson resources related to CARIN claims data are gathered'
    description %(
      This test will look through all returned RelatedPerson resources for a specific expected RelatedPerson
      resource that supports the CARIN for Blue Button [RelatedPerson profile](https://hl7.org/fhir/us/carin-bb/STU2/StructureDefinition-C4BB-RelatedPerson.html)
      on the Inferno Reference Server.
    )
    input :access_token

    run do
      resources = previous_resource_requests(:RelatedPerson)
      skip_if resources.nil?, 'No requests made for RelatedPerson resources'

      assert resources.any? { |resource| resource.id == 'c4bb-RelatedPerson' },
             'Unable to find expected resource: c4bb-RelatedPerson'
    end
  end
end
