module CarinForBlueButtonTestKit
  class AttestationTestCarinV2Requirement156 < Inferno::Test
    title 'Maps CPCDS data when line item data is unavailable'
    description <<~DESCRIPTION
      The Health IT Module maps CPCDS data to either `EOB.item` or `EOB.header` as appropriate:
          - When line item amounts are available, they are provided in `EOB.item`.
          - When line item amounts are not available, claim-level amounts and amount types are provided in `EOB.header`.
    DESCRIPTION
    id :carin_server_requirement_156_attestation

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@156'

    input :carin_server_requirement_156_attestation_options,
          title: 'Maps CPCDS data when line item data is unavailable',
          description: %(
            I attest that the Health IT Module maps CPCDS data to either `EOB.item` or `EOB.header` as appropriate:
              - When line item amounts are available, they are provided in `EOB.item`.
              - When line item amounts are not available, claim-level amounts and amount types are provided in `EOB.header`.
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
    input :carin_server_requirement_156_attestation_note,
          title: 'Notes, if applicable:',
          type: 'textarea',
          optional: true



    run do
      assert carin_server_requirement_156_attestation_options == 'true',
             'Client application did not demonstrate correct usage of the authorization code.'
      pass carin_server_requirement_156_attestation_note if carin_server_requirement_156_attestation_note.present?
    end

  end
end
