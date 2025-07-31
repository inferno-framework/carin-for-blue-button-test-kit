module CarinForBlueButtonTestKit
  class AttestationTestCarinV2Requirement164 < Inferno::Test
    title 'Populates "quantity" for all compound code values'
    description <<~DESCRIPTION
      The `item.quantity` element is populated for all Compound Code values.
    DESCRIPTION
    id :carin_server_requirement_164_attestation

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@164'

    input :carin_server_requirement_164_attestation_options,
          title: 'Populates "quantity" for all compound code values',
          description: %(
            I attest that the `item.quantity` element is populated for all Compound Code values.
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
    input :carin_server_requirement_164_attestation_note,
          title: 'Notes, if applicable:',
          type: 'textarea',
          optional: true

    run do
      assert carin_server_requirement_164_attestation_options == 'true', %(
        The following was not satisfied:

          The `item.quantity` element is populated for all Compound Code values.

      )
      pass carin_server_requirement_164_attestation_note if carin_server_requirement_164_attestation_note.present?
    end

  end
end
