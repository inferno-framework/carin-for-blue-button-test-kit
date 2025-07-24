module CarinForBlueButtonTestKit
  class AttestationTestCarinV2Requirement97 < Inferno::Test
    title 'Responds with appropriate error codes'
    description <<~DESCRIPTION
      The Health IT Module returns the following response classes:
      - (Status 400): invalid parameter
      - (Status 401/4xx): unauthorized request
      - (Status 403): insufficient scope
      - (Status 404): unknown resource
      - (Status 410): deleted resource

      The Health IT Module rejects any unauthorized request by returning an HTTP 401 "Unauthorized", HTTP 403 "Forbidden",
      or HTTP 404 "Not Found".
    DESCRIPTION
    id :carin_server_requirement_97_attestation

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@97', 'hl7.fhir.us.carin-bb_2.0.0@102'

    input :carin_server_requirement_97_attestation_options,
          title: 'Responds with appropriate error codes',
          description: %(
            I attest that the Health IT Module returns the following response classes:
              - (Status 400): invalid parameter
              - (Status 401/4xx): unauthorized request
              - (Status 403): insufficient scope
              - (Status 404): unknown resource
              - (Status 410): deleted resource

              I further attest that the Health IT Module rejects any unauthorized request by returning an HTTP 401 "Unauthorized",
              HTTP 403 "Forbidden", or HTTP 404 "Not Found".
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
    input :carin_server_requirement_97_attestation_note,
          title: 'Notes, if applicable:',
          type: 'textarea',
          optional: true



    run do
      assert carin_server_requirement_97_attestation_options == 'true',
             'Client application did not demonstrate correct usage of the authorization code.'
      pass carin_server_requirement_97_attestation_note if carin_server_requirement_97_attestation_note.present?
    end

  end
end
