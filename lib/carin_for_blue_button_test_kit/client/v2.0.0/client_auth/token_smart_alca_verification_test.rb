require 'smart_app_launch_test_kit'

module CarinForBlueButtonTestKit
  class C4BBV200ClientTokenSMARTConfidentialAsymmetricVerification <
    SMARTAppLaunch::SMARTClientTokenRequestAppLaunchConfidentialAsymmetricVerification
    id :c4bb_v200_client_token_smart_alca_verification

    def client_suite_id
      CarinForBlueButtonTestKit::C4BBV200ClientSuite.id
    end
  end
end
