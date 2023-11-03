# frozen_string_literal: true

module CarinForBlueButtonTestKit
  module CARIN4BBV200DEVNONFINANCIAL
    class WellKnownCapabilitiesTest < Inferno::Test
      id :c4bb_v200devnonfinancial_smart_capabilities
      title 'Server Well-known configuration declares support for the required SMART capabilities'
      description %(
        Servers SHALL support the following [SMART on FHIR
        capabilities](https://hl7.org/fhir/us/carin-bb/Security_And_Privacy_Considerations.html#authentication-and-authorization-requirements):

        * `launch-standalone`
        * `client-public`
        * `client-confidential-symmetric`
        * `sso-openid-connect`
        * `context-standalone-patient`
        * `permission-offline`
        * `permission-patient`
        * `permission-user`
      )

      input :well_known_configuration

      run do
        skip_if well_known_configuration.blank?, 'No SMART well-known configuration received'

        assert_valid_json(well_known_configuration)

        advertised_capabilities = JSON.parse(well_known_configuration)['capabilities']

        assert advertised_capabilities.is_a?(Array),
               "Expected `capabilities` field to be an Array, but found #{advertised_capabilities.class.name}"

        required_capabilities = config.options[:required_capabilities] || []

        missing_capabilities = required_capabilities - advertised_capabilities

        missing_capabilities_string =
          missing_capabilities
          .map { |capability| "\n* `#{capability}`" }
          .join

        assert missing_capabilities.empty?,
               "
               Server did not advertise support for the following required capabilities:
               #{missing_capabilities_string}
               "
      end
    end
  end
end
