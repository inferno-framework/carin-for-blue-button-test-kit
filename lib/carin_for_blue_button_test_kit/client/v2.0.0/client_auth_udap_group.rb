require 'udap_security_test_kit'
require_relative 'client_auth/authorization_udap_verification_test'
require_relative 'client_auth/token_udap_verification_test'

module CarinForBlueButtonTestKit
  class C4BBV200ClientAuthUDAPGroup < Inferno::TestGroup
    id :c4bb_v200_client_auth_udap
    title 'Review UDAP Authentication Interactions'
    description %(
      During these tests, Inferno will verify that the client interacted with Inferno's
      simulated UDAP authorization server in a conformant manner when requesting access tokens
      and that the client under test was able to use provided access tokens to make CARIN
      requests.

      Before running these tests, perform the Data Access group so that the client
      will request an access token and use it on a data access request.
    )
    run_as_group

    test from: :c4bb_v200_client_authorization_udap_verification
    test from: :c4bb_v200_client_token_udap_verification
    test from: :udap_client_token_use_verification,
          config: {
            options: { access_request_tags: [RESOURCE_ID_TAG, RESOURCE_API_TAG] }
          }
  end
end
