require_relative '../urls'
require_relative '../client_validation_test'

module CarinForBlueButtonTestKit
  class C4BBClientPatientSearchBirthdate < Inferno::Test
    include URLs
    include CarinForBlueButtonTestKit::ClientValidationTest

    id :patient_search_birthdate
    title 'Patient required search made with `birthdate` parameter'
    description %(
      This test will look through all the requests for a Patient search request with the `birthdate` parameter
    )
    input :access_token

    run do
      search_request = load_tagged_requests(SUBMIT_TAG, 'birthdate')
      requests =
        search_request
          .select { |request| request.status == 200 }
      skip_if requests.empty?, 'No successful Patient searches with `birthdate` search parameter made'
    end
  end
end
