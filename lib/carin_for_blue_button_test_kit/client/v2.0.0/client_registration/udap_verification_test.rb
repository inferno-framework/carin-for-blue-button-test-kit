require 'udap_security_test_kit'

module CarinForBlueButtonTestKit
  class C4BBV200ClientRegistrationUDAPVerification < UDAPSecurityTestKit::UDAPClientRegistrationAuthorizationCodeVerification
    id :c4bb_v200_client_reg_udap_verification

    def client_suite_id
      CarinForBlueButtonTestKit::C4BBV200ClientSuite.id
    end
  end
end
