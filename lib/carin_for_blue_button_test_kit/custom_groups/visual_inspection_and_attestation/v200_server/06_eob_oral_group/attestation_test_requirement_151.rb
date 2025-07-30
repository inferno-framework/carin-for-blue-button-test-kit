module CarinForBlueButtonTestKit
  class AttestationTestCarinV2Requirement151 < Inferno::Test
    title 'Specifies primary body site'
    description <<~DESCRIPTION
      The primary body site for each line item (tooth or oral cavity) is specified in the
      `item.bodySite` element of the ExplanationOfBenefit resource.
    DESCRIPTION
    id :carin_server_requirement_151_attestation

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@151'

    input :carin_server_requirement_151_attestation_options,
          title: 'Specifies primary body site',
          description: %(
            I attest that the primary body site for each line item (tooth or oral cavity) is specified in the
              `item.bodySite` element of the ExplanationOfBenefit resource.
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
    input :carin_server_requirement_151_attestation_note,
          title: 'Notes, if applicable:',
          type: 'textarea',
          optional: true

    run do
      assert carin_server_requirement_151_attestation_options == 'true', %(
        The following was not satisfied:

          The primary body site for each line item (tooth or oral cavity) is specified in the
          `item.bodySite` element of the ExplanationOfBenefit resource.

      )
      pass carin_server_requirement_151_attestation_note if carin_server_requirement_151_attestation_note.present?
    end

  end
end
