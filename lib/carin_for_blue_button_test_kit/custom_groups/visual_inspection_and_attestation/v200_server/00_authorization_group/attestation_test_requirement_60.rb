module CarinForBlueButtonTestKit
  class AttestationTestCarinV2Requirement60_67 < Inferno::Test
    title 'Supports SMART Core Capabilities'
    description <<~DESCRIPTION
      The Health IT Module supports the following “SMART Core Capabilities”:
      - `launch-standalone`: support for SMART’s Standalone Launch mode
      - `client-public`: support for SMART’s public client profile (no client authentication)
      - `client-confidential-symmetric`: support for SMART’s confidential client profile
      - `sso-openid-connect`: support for SMART’s OpenID Connect profile
      - `context-standalone-patient`: support for patient-level launch context (requested by launch/patient scope, conveyed via patient token parameter)
      - `permission-offline`: support for refresh tokens (requested by offline_access scope)
      - `permission-patient`: support for patient-level scopes (e.g. patient Observation.read)
      - `permission-user`: support for user-level scopes (e.g. user/Appointment.read)
    DESCRIPTION
    id :carin_server_requirement_60_67_attestation

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@60',
                          'hl7.fhir.us.carin-bb_2.0.0@61',
                          'hl7.fhir.us.carin-bb_2.0.0@62',
                          'hl7.fhir.us.carin-bb_2.0.0@63',
                          'hl7.fhir.us.carin-bb_2.0.0@64',
                          'hl7.fhir.us.carin-bb_2.0.0@65',
                          'hl7.fhir.us.carin-bb_2.0.0@66',
                          'hl7.fhir.us.carin-bb_2.0.0@67'

    input :carin_server_requirement_60_67_attestation_options,
          title: 'Supports SMART Core Capabilities',
          description: %(
            The Health IT Module supports the following “SMART Core Capabilities”:
              - `launch-standalone`: support for SMART’s Standalone Launch mode
              - `client-public`: support for SMART’s public client profile (no client authentication)
              - `client-confidential-symmetric`: support for SMART’s confidential client profile
              - `sso-openid-connect`: support for SMART’s OpenID Connect profile
              - `context-standalone-patient`: support for patient-level launch context (requested by launch/patient scope, conveyed via patient token parameter)
              - `permission-offline`: support for refresh tokens (requested by offline_access scope)
              - `permission-patient`: support for patient-level scopes (e.g. patient Observation.read)
              - `permission-user`: support for user-level scopes (e.g. user/Appointment.read)
          ),
          type: 'radio',
          default: 'false',
          options: {
            list_options: [
              {
                label: 'Yes',
                value: 'true'
              },
              {
                label: 'No',
                value: 'false'
              }
            ]
          }
    input :carin_server_requirement_60_67_attestation_note,
          title: 'Notes, if applicable:',
          type: 'textarea',
          optional: true



    run do
      assert carin_server_requirement_60_67_attestation_options == 'true',
             'Client application did not demonstrate correct usage of the authorization code.'
      pass carin_server_requirement_60_67_attestation_note if carin_server_requirement_60_67_attestation_note.present?
    end

  end
end
