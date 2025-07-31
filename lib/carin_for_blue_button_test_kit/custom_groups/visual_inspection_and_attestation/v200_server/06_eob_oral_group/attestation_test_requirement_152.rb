module CarinForBlueButtonTestKit
  class AttestationTestCarinV2Requirement152 < Inferno::Test
    title 'Specifies additional body sites'
    description <<~DESCRIPTION
      Additional body sites (tooth or oral cavity) are specified in `supportingInfo[additionalbodysite]`
      elements, and that each `supportingInfo[additionalbodysite].sequence` matches the associated line item's
      `item.informationSequence`.
    DESCRIPTION
    id :carin_server_requirement_152_attestation

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@152'

    input :carin_server_requirement_152_attestation_options,
          title: 'Specifies additional body sites',
          description: %(
            I attest that additional body sites (tooth or oral cavity) are specified in `supportingInfo[additionalbodysite]`
              elements, and that each `supportingInfo[additionalbodysite].sequence` matches the associated line item's
              `item.informationSequence`.
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
    input :carin_server_requirement_152_attestation_note,
          title: 'Notes, if applicable:',
          type: 'textarea',
          optional: true

    run do
      assert carin_server_requirement_152_attestation_options == 'true', %(
        The following was not satisfied:

          Additional body sites (tooth or oral cavity) are specified in `supportingInfo[additionalbodysite]`
          elements, and that each `supportingInfo[additionalbodysite].sequence` matches the associated line item's
          `item.informationSequence`.

      )
      pass carin_server_requirement_152_attestation_note if carin_server_requirement_152_attestation_note.present?
    end

  end
end
