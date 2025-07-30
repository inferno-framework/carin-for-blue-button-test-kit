module CarinForBlueButtonTestKit
  class AttestationTestCarinV2Requirement118 < Inferno::Test
    title 'Updates reference when the reference adjusts another reference'
    description <<~DESCRIPTION
      When an ExplanationOfBenefit resource returned by the Health IT Module
      adjusts a prior ExplanationOfBenefit, the `.related.reference`
      field is populated with the identifier of the prior ExplanationOfBenefit, and the `.related.relationship` field
      is assigned the value `prior`.
    DESCRIPTION
    id :carin_server_requirement_118_attestation

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@118'

    input :carin_server_requirement_118_attestation_options,
          title: 'Updates reference when the reference adjusts another reference',
          description: %(
            I attest that when an ExplanationOfBenefit resource returned by the Health IT Module
              adjusts a prior ExplanationOfBenefit, the `.related.reference`
              field is populated with the identifier of the prior ExplanationOfBenefit, and the `.related.relationship` field
              is assigned the value `prior`.
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
    input :carin_server_requirement_118_attestation_note,
          title: 'Notes, if applicable:',
          type: 'textarea',
          optional: true

    run do
      assert carin_server_requirement_118_attestation_options == 'true', %(
        The following was not satisfied:

          When an ExplanationOfBenefit resource returned by the Health IT Module
          adjusts a prior ExplanationOfBenefit, the `.related.reference`
          field is populated with the identifier of the prior ExplanationOfBenefit, and the `.related.relationship` field
          is assigned the value `prior`.

      )
      pass carin_server_requirement_118_attestation_note if carin_server_requirement_118_attestation_note.present?
    end

  end
end
