module CarinForBlueButtonTestKit
  class AttestationTestCarinV2Requirement119 < Inferno::Test
    title 'Updates reference when the reference is adjusted by another reference'
    description <<~DESCRIPTION
      When an ExplanationOfBenefit resource returned by the Health IT Module
      has been adjusted by another ExplanationOfBenefit,
      the `.related.reference` field is populated with the identifier of the adjusting ExplanationOfBenefit,
      and the `.related.relationship` field is assigned the value `replacedby`.
    DESCRIPTION
    id :carin_server_requirement_119_attestation

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@119'

    input :carin_server_requirement_119_attestation_options,
          title: 'Updates reference when the reference is adjusted by another reference',
          description: %(
            I attest that when an ExplanationOfBenefit resource returned by the Health IT Module
              has been adjusted by another ExplanationOfBenefit,
              the `.related.reference` field is populated with the identifier of the adjusting ExplanationOfBenefit,
              and the `.related.relationship` field is assigned the value `replacedby`.
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
    input :carin_server_requirement_119_attestation_note,
          title: 'Notes, if applicable:',
          type: 'textarea',
          optional: true

    run do
      assert carin_server_requirement_119_attestation_options == 'true', %(
        The following was not satisfied:

          When an ExplanationOfBenefit resource returned by the Health IT Module
          has been adjusted by another ExplanationOfBenefit,
          the `.related.reference` field is populated with the identifier of the adjusting ExplanationOfBenefit,
          and the `.related.relationship` field is assigned the value `replacedby`.

      )
      pass carin_server_requirement_119_attestation_note if carin_server_requirement_119_attestation_note.present?
    end

  end
end
