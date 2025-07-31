module CarinForBlueButtonTestKit
  class AttestationTestCarinV2Requirement120 < Inferno::Test
    title 'Reference contains identifier of immediately preceding or following ExplanationOfBenefit'
    description <<~DESCRIPTION
      The `.related.reference` field in an ExplanationOfBenefit resource
      returned by the Health IT Module contains the identifier
      of the immediately preceding or following ExplanationOfBenefit, and not the first or last in a sequence.
    DESCRIPTION
    id :carin_server_requirement_120_attestation

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@120'

    input :carin_server_requirement_120_attestation_options,
          title: 'Reference contains identifier of immediately preceding or following ExplanationOfBenefit',
          description: %(
            I attest that the `.related.reference` field in an ExplanationOfBenefit resource
              returned by the Health IT Module contains the identifier
              of the immediately preceding or following ExplanationOfBenefit, and not the first or last in a sequence.
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
    input :carin_server_requirement_120_attestation_note,
          title: 'Notes, if applicable:',
          type: 'textarea',
          optional: true

    run do
      assert carin_server_requirement_120_attestation_options == 'true', %(
        The following was not satisfied:

          The `.related.reference` field in an ExplanationOfBenefit resource
          returned by the Health IT Module contains the identifier
          of the immediately preceding or following ExplanationOfBenefit, and not the first or last in a sequence.

      )
      pass carin_server_requirement_120_attestation_note if carin_server_requirement_120_attestation_note.present?
    end

  end
end
