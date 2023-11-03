# frozen_string_literal: true

module CarinForBlueButtonTestKit
  module CARIN4BBV200
    class WellKnownSupportedScopesTest < Inferno::Test
      id :c4bb_v200_wellknown_supported_scopes
      title 'Server Well-known configuration declares support for the required authorization scopes'
      description %(
        Server SHALL support, at a minimum, the following requested authorization scopes:
          * `openid`
          * `fhirUser`
          * `launch/patient`
          * `patient/ExplanationOfBenefit.read`
          * `patient/Coverage.read`
          * `patient/Patient.read`
          * `patient/Organization.read`
          * `patient/Practitioner.read`
          * `user/ExplanationOfBenefit.read`
          * `user/Coverage.read`
          * `user/Patient.read`
          * `user/Organization.read`
          * `user/Practitioner.read`
      )

      input :well_known_configuration

      run do
        skip_if well_known_configuration.blank?, 'No SMART well-known configuration received'

        assert_valid_json(well_known_configuration)

        supported_scopes = JSON.parse(well_known_configuration)['scopes_supported']

        assert !supported_scopes.nil?, 'Well-known configuration does not include scopes_supported'
        assert supported_scopes.is_a?(Array),
               "Expected `scopes_supported` field to be an Array, but found #{supported_scopes.class.name}"

        required_scopes = config.options[:required_scopes] || []
        missing_scopes = required_scopes - supported_scopes

        missing_scopes_string =
          missing_scopes
          .map { |scope| "\n* `#{scope}`" }
          .join

        assert missing_scopes.empty?,
               "Server did not advertise support for the following required scopes: #{missing_scopes_string}"
      end
    end
  end
end
