require 'smart_app_launch_test_kit'

module CarinForBlueButtonTestKit
  class C4BBV200ClientAuthorizationSMARTVerification <
    SMARTAppLaunch::SMARTClientAppLaunchAuthorizationRequestVerification
    id :c4bb_v200_client_authorization_smart_verification

    def client_suite_id
      CarinForBlueButtonTestKit::C4BBV200ClientSuite.id
    end
  end
end
