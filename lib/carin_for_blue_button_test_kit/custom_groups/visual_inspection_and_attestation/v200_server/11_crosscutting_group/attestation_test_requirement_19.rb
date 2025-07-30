module CarinForBlueButtonTestKit
  class AttestationTestCarinV2Requirement19 < Inferno::Test
    title 'Uses code display string'
    description <<~DESCRIPTION
      The Health IT Module ensures that when the `display` element is populated,
      it contains one of the display strings defined for the associated code
      in the code system.
    DESCRIPTION
    id :carin_server_requirement_19_attestation

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@19'

    input :carin_server_requirement_19_attestation_options,
          title: 'Uses code display string',
          description: %(
            I attest that when the `display` element is populated, the Health IT Module uses a valid display string defined
              for that code by the code system (which may allow multiple valid display strings).
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
    input :carin_server_requirement_19_attestation_note,
          title: 'Notes, if applicable:',
          type: 'textarea',
          optional: true

    run do
      assert carin_server_requirement_19_attestation_options == 'true', %(
        The following was not satisfied:

          The Health IT Module ensures that when the `display` element is populated,
          it contains one of the display strings defined for the associated code
          in the code system.

      )
      pass carin_server_requirement_19_attestation_note if carin_server_requirement_19_attestation_note.present?
    end

  end
end
