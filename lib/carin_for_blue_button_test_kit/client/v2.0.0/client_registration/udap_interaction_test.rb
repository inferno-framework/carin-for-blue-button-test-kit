require 'udap_security_test_kit'

module CarinForBlueButtonTestKit
  class C4BBV200ClientRegistrationUDAPInteraction < UDAPSecurityTestKit::UDAPClientRegistrationInteraction
    id :c4bb_v200_client_reg_udap_interaction

    def client_suite_id
      CarinForBlueButtonTestKit::C4BBV200ClientSuite.id
    end
  end
end
