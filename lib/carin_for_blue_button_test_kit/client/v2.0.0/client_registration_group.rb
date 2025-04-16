require 'udap_security_test_kit'
require 'smart_app_launch_test_kit'
require_relative 'client_options'
require_relative 'client_registration/udap_interaction_test'
require_relative 'client_registration/udap_verification_test'
require_relative 'client_registration/configuration_display_smart_test'
require_relative 'client_registration/configuration_display_udap_test'
require_relative 'client_registration/configuration_display_other_test'
require_relative 'client_registration/other_auth_attest_test'

module CarinForBlueButtonTestKit
  class CarinClientRegistrationGroup < Inferno::TestGroup
    id :c4bb_v200_client_registration
    title 'Client Registration'
    description %(
      Register the client under test with Inferno's simulated CARIN Server,
      including configuration of the system under test to hit the correct endpoints and
      enable authentication and authorization of CARIN requests.
    )
    run_as_group

    # smart registration tests
    test from: :smart_client_registration_alca_verification,
          required_suite_options: {
            client_type: CarinClientOptions::SMART_APP_LAUNCH_CONFIDENTIAL_ASYMMETRIC
          }
    test from: :smart_client_registration_alcs_verification,
          required_suite_options: {
            client_type: CarinClientOptions::SMART_APP_LAUNCH_CONFIDENTIAL_SYMMETRIC
          }
    test from: :smart_client_registration_alp_verification,
          required_suite_options: {
            client_type: CarinClientOptions::SMART_APP_LAUNCH_PUBLIC
          }
    test from: :c4bb_v200_client_reg_config_smart_display,
          id: :c4bb_v200_client_reg_config_smart_alca_display,
          required_suite_options: {
            client_type: CarinClientOptions::SMART_APP_LAUNCH_CONFIDENTIAL_ASYMMETRIC
          }
    test from: :c4bb_v200_client_reg_config_smart_display,
          id: :c4bb_v200_client_reg_config_smart_alcs_display,
          required_suite_options: {
            client_type: CarinClientOptions::SMART_APP_LAUNCH_CONFIDENTIAL_SYMMETRIC
          }
    test from: :c4bb_v200_client_reg_config_smart_display,
          id: :c4bb_v200_client_reg_config_smart_alp_display,
          required_suite_options: {
            client_type: CarinClientOptions::SMART_APP_LAUNCH_PUBLIC
          }

    # udap registration tests
    test from: :c4bb_v200_client_reg_udap_interaction,
          required_suite_options: {
            client_type: CarinClientOptions::UDAP_AUTHORIZATION_CODE
          }
    test from: :c4bb_v200_client_reg_udap_verification,
          required_suite_options: {
            client_type: CarinClientOptions::UDAP_AUTHORIZATION_CODE
          }
    test from: :c4bb_v200_client_reg_config_udap_display,
          required_suite_options: {
            client_type: CarinClientOptions::UDAP_AUTHORIZATION_CODE
          }

    # other registration tests
    test from: :c4bb_v200_client_reg_other_auth_attest,
          required_suite_options: {
            client_type: CarinClientOptions::DEDICATED_ENDPOINTS
          }
    test from: :c4bb_v200_client_reg_config_other_display,
          required_suite_options: {
            client_type: CarinClientOptions::DEDICATED_ENDPOINTS
          }
  end
end
