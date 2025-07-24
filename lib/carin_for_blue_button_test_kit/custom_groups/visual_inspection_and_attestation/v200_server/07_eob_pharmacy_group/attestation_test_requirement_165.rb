module CarinForBlueButtonTestKit
  class AttestationTestCarinV2Requirement165 < Inferno::Test
    title 'Adds ingredient quantity information'
    description <<~DESCRIPTION
      When the Compound Code is 2, and ingredient quantity information is available,
      it is mapped to `item.detail.quantity`.
    DESCRIPTION
    id :carin_server_requirement_165_attestation

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@165'

    input :carin_server_requirement_165_attestation_options,
          title: 'Adds ingredient quantity information',
          description: %(
            I attest that when the Compound Code is 2, and ingredient quantity information is available,
              it is mapped to `item.detail.quantity`.
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
    input :carin_server_requirement_165_attestation_note,
          title: 'Notes, if applicable:',
          type: 'textarea',
          optional: true



    run do
      assert carin_server_requirement_165_attestation_options == 'true',
             'Client application did not demonstrate correct usage of the authorization code.'
      pass carin_server_requirement_165_attestation_note if carin_server_requirement_165_attestation_note.present?
    end

  end
end
