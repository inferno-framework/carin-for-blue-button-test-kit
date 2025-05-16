require 'smart_app_launch_test_kit'

module CarinForBlueButtonTestKit
  class C4BBV200ClientAuthSMARTPublicGroup < Inferno::TestGroup
    id :c4bb_v200_client_auth_smart_alp
    title 'Review Authentication Interactions'
    description %(
      During these tests, Inferno will verify that the client interacted with Inferno's
      simulated SMART authorization server in a conformant manner when requesting access tokens
      and that the client under test was able to use provided access tokens to make CARIN
      requests.

      Before running these tests, perform the Data Access group so that the client
      will request an access token and use it on a data access request.
    )
    run_as_group

    # smart auth verification
    test from: :smart_client_authorization_request_verification,
         id: :c4bb_v200_client_authorization_smart_alp_verification,
         config: { options: { endpoint_suite_id: :c4bb_v200_client } }
    test from: :smart_client_token_request_alp_verification,
         id: :c4bb_v200_client_token_smart_alp_verification,
         config: { options: { endpoint_suite_id: :c4bb_v200_client } }
    test from: :smart_client_token_use_verification,
          config: {
            options: { access_request_tags: [RESOURCE_ID_TAG, RESOURCE_API_TAG] }
          }
  end
end
