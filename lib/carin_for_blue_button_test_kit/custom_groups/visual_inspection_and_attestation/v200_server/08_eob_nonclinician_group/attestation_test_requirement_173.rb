module CarinForBlueButtonTestKit
  class AttestationTestCarinV2Requirement173 < Inferno::Test
    title 'Associates supportingInfo with line items'
    description <<~DESCRIPTION
      Every `supportingInfo` repetition with a Transportation Services Category code is associated
      with at least one ExplanationOfBenefit line item by referencing `supportingInfo.sequence` through the
      `item.informationSequence` element.
    DESCRIPTION
    id :carin_server_requirement_173_attestation

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@173'

    input :carin_server_requirement_173_attestation_options,
          title: 'Associates supportingInfo with line items',
          description: %(
            I attest that every `supportingInfo` repetition with a Transportation Services Category code is associated
              with at least one ExplanationOfBenefit line item by referencing `supportingInfo.sequence` through the
              `item.informationSequence` element.
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
    input :carin_server_requirement_173_attestation_note,
          title: 'Notes, if applicable:',
          type: 'textarea',
          optional: true


        run do
          assert carin_server_requirement_173_attestation_options == 'true', %(
            The following was not satisfied:

            Every `supportingInfo` repetition with a Transportation Services Category code is associated
            with at least one ExplanationOfBenefit line item by referencing `supportingInfo.sequence` through the
            `item.informationSequence` element.

          )
          pass carin_server_requirement_173_attestation_note if carin_server_requirement_173_attestation_note.present?
        end

  end
end
