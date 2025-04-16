require 'udap_security_test_kit'

module CarinForBlueButtonTestKit
  class C4BBV200ClientAuthorizationUDAPVerification <
    UDAPSecurityTestKit::UDAPClientAppLaunchAuthorizationRequestVerification
    id :c4bb_v200_client_authorization_udap_verification

    def client_suite_id
      CarinForBlueButtonTestKit::C4BBV200ClientSuite.id
    end
  end
end
