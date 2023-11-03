# frozen_string_literal: true

module CarinForBlueButtonTestKit
  module CARIN4BBV200DEVNONFINANCIAL
    class SmartScopesTest < Inferno::Test
      id :c4bb_v200devnonfinancial_smart_scopes
      title 'Server supports the required authorization scopes.'
      description %(
        All required scopes requested are expected to be granted.
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
      input :requested_scopes, :received_scopes
      uses_request :token

      def required_scopes
        config.options[:required_scopes]
      end

      run do
        skip_if request.status != 200, 'Token exchange was unsuccessful'
        [
          {
            scopes: requested_scopes,
            received_or_requested: 'requested'
          },
          {
            scopes: received_scopes,
            received_or_requested: 'received'
          }
        ].each do |metadata|
          scopes = metadata[:scopes].split
          received_or_requested = metadata[:received_or_requested]
          missing_scopes = required_scopes - scopes
          assert missing_scopes.empty?,
                 "Required scopes were not #{received_or_requested}: #{missing_scopes.join(', ')}"
        end
      end
    end
  end
end
