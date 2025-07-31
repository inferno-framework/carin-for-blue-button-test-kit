module CarinForBlueButtonTestKit
  class AttestationTestCarinV2Requirement161 < Inferno::Test
    title 'Populates with an NDC code'
    description <<~DESCRIPTION
      When the Compound Code (MapID 78) is 0 or 1, the `item.productOrService` element is
      populated with an NDC code.
    DESCRIPTION
    id :carin_server_requirement_161_attestation

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@161'

    input :carin_server_requirement_161_attestation_options,
          title: 'Populates with an NDC code',
          description: %(
            I attest that when the Compound Code (MapID 78) is 0 or 1, the `item.productOrService` element is
              populated with an NDC code.
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
    input :carin_server_requirement_161_attestation_note,
          title: 'Notes, if applicable:',
          type: 'textarea',
          optional: true

    run do
      assert carin_server_requirement_161_attestation_options == 'true', %(
        The following was not satisfied:

          When the Compound Code (MapID 78) is 0 or 1, the `item.productOrService` element is
          populated with an NDC code.

      )
      pass carin_server_requirement_161_attestation_note if carin_server_requirement_161_attestation_note.present?
    end

  end
end
