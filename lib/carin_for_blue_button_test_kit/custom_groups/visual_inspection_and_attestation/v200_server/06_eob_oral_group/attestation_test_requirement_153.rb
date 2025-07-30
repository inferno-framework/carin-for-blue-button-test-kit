module CarinForBlueButtonTestKit
  class AttestationTestCarinV2Requirement153 < Inferno::Test
    title 'Applies oral line item subsites to associated tooth surfaces'
    description <<~DESCRIPTION
      All oral line item subsites (`item.subSite` repetitions) apply to all the line item's
      associated tooth surfaces, including those specified in `item.bodySite` and `supportingInfo[additionalbodysite]`,
      with the association established through matching `supportingInfo[additionalbodysite].sequence` values in
      `item.informationSequence`.
    DESCRIPTION
    id :carin_server_requirement_153_attestation

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@153'

    input :carin_server_requirement_153_attestation_options,
          title: 'Applies oral line item subsites to associated tooth surfaces',
          description: %(
            I attest that all oral line item subsites (`item.subSite` repetitions) apply to all the line item's
              associated tooth surfaces, including those specified in `item.bodySite` and `supportingInfo[additionalbodysite]`,
              with the association established through matching `supportingInfo[additionalbodysite].sequence` values in
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
    input :carin_server_requirement_153_attestation_note,
          title: 'Notes, if applicable:',
          type: 'textarea',
          optional: true


        run do
          assert carin_server_requirement_153_attestation_options == 'true', %(
            The following was not satisfied:

            All oral line item subsites (`item.subSite` repetitions) apply to all the line item's
            associated tooth surfaces, including those specified in `item.bodySite` and `supportingInfo[additionalbodysite]`,
            with the association established through matching `supportingInfo[additionalbodysite].sequence` values in
            `item.informationSequence`.

          )
          pass carin_server_requirement_153_attestation_note if carin_server_requirement_153_attestation_note.present?
        end

  end
end
