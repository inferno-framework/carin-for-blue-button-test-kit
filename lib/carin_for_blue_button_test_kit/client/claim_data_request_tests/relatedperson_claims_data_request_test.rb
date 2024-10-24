require_relative '../urls'
require_relative '../client_validation_test'

module CarinForBlueButtonTestKit
  class C4BBClientRelatedPersonSubmitClaimsDataRequestTest < Inferno::Test
    include URLs
    include CarinForBlueButtonTestKit::ClientValidationTest

    id :relatedperson_claims_data_request_test
    title 'RelatedPerson resources related to Carin claims data are gathered'
    description %(
      This test will look through all returned RelatedPerson resources for a specific expected RelatedPerson resource.
    )
    input :access_token

    run do
      skip_if scratch[:RelatedPerson].nil?, 'No requests made for RelatedPerson resources'

      assert scratch[:RelatedPerson].any? { |resource| resource.id == 'c4bb-RelatedPerson' },
             'Unable to find expected resource: c4bb-RelatedPerson'
    end
  end
end
