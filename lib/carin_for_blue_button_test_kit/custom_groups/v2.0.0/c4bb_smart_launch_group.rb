# frozen_string_literal: true

require_relative 'c4bb_smart_launch/well_known_capabilities_test'
require_relative 'c4bb_smart_launch/smart_scopes_test'

module CarinForBlueButtonTestKit
  module CARIN4BBV200
    class C4BBSMARTLaunchGroup < Inferno::TestGroup
      id :c4bb_v200_smart_launch
      title 'SMART App Launch'
      description %(
        # Background
        Applications authorize to gain access to a patient record using the
        [SMART App Launch
        Protocol](http://hl7.org/fhir/smart-app-launch/1.0.0/)'s standalone
        launch sequence.

        # Testing Methodology
        These tests first access the server's SMART discovery endpoints and
        verify that they are available and that the server advertises support
        for the required SMART capabilities and required authorization scopes.
        They then perform a standalone launch to obtain an access token which
        can be used by the remaining tests to access patient data.
      )

      config(
        inputs: {
          received_scopes: { name: :standalone_received_scopes },
          smart_auth_info: {
            options: {
              components: [
                {
                  name: :requested_scopes,
                  default: %(
                    launch/patient openid fhirUser
                    patient/ExplanationOfBenefit.read patient/Coverage.read
                    patient/Patient.read patient/Organization.read
                    patient/Practitioner.read user/ExplanationOfBenefit.read
                    user/Coverage.read user/Patient.read
                    user/Organization.read user/Practitioner.read
                  ).gsub(/\s{2,}/, ' ').strip
                }
              ]
            }
          }
        },
        outputs: {
          patient_id: { name: :patient_ids }
        }
      )

      group from: :smart_discovery do
        run_as_group
        verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@58'

        test from: :c4bb_v200_smart_capabilities do
          config(
            options: {
              required_capabilities: %w[
                launch-standalone
                client-public
                client-confidential-symmetric
                sso-openid-connect
                context-standalone-patient
                permission-offline
                permission-patient
                permission-user
              ]
            }
          )
        end
      end

      group from: :smart_standalone_launch do
        run_as_group
        description %(
          # Background

          The [Standalone
          Launch Sequence](https://www.hl7.org/fhir/smart-app-launch/1.0.0/index.html#standalone-launch-sequence)
          allows an app, like Inferno, to be launched independent of an
          existing EHR session. It is one of the two launch methods described in
          the SMART App Launch Framework alongside EHR Launch. The app will
          request authorization for the provided scope from the authorization
          endpoint, ultimately receiving an authorization token which can be used
          to gain access to resources on the FHIR server.

          # Test Methodology

          Inferno will redirect the user to the authorization endpoint so that
          they can provide any required credentials and authorize the application.
          Upon successful authorization, Inferno will exchange the authorization
          code provided for an access token.

          For more information on the #{title}:

          * [Standalone Launch Sequence](https://www.hl7.org/fhir/smart-app-launch/1.0.0/index.html#standalone-launch-sequence)
        )
        verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@1', 'hl7.fhir.us.carin-bb_2.0.0@60',
                              'hl7.fhir.us.carin-bb_2.0.0@68', 'hl7.fhir.us.carin-bb_2.0.0@69',
                              'hl7.fhir.us.carin-bb_2.0.0@70', 'hl7.fhir.us.carin-bb_2.0.0@71',
                              'hl7.fhir.us.carin-bb_2.0.0@72', 'hl7.fhir.us.carin-bb_2.0.0@73',
                              'hl7.fhir.us.carin-bb_2.0.0@74', 'hl7.fhir.us.carin-bb_2.0.0@75',
                              'hl7.fhir.us.carin-bb_2.0.0@76', 'hl7.fhir.us.carin-bb_2.0.0@77',
                              'hl7.fhir.us.carin-bb_2.0.0@78', 'hl7.fhir.us.carin-bb_2.0.0@79',
                              'hl7.fhir.us.carin-bb_2.0.0@80', 'hl7.fhir.us.carin-bb_2.0.0@81'

        test from: :c4bb_v200_smart_scopes do
          config(
            options: {
              required_scopes: %w[
                openid
                fhirUser
                launch/patient
                patient/ExplanationOfBenefit.read
                patient/Coverage.read
                patient/Patient.read
                patient/Organization.read
                patient/Practitioner.read
                user/ExplanationOfBenefit.read
                user/Coverage.read
                user/Patient.read
                user/Organization.read
                user/Practitioner.read
              ]
            }
          )
        end
      end
    end
  end
end
