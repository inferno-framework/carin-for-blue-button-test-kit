module CarinForBlueButtonTestKit
  class AttestationTestCarinV2Requirement168 < Inferno::Test
    title 'Sequentially numbers and properly references diagnosis.sequence'
    description <<~DESCRIPTION
      The Health IT Module sequentially numbers all diagnoses at the ExplanationOfBenefit header
      level using the `diagnosis.sequence` element. I further attest that each `item.diagnosisSequence` element
      references the appropriate `diagnosis.sequence` number from the header-level diagnoses.
    DESCRIPTION
    id :carin_server_requirement_168_170_attestation

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@168', 'hl7.fhir.us.carin-bb_2.0.0@170'

    input :carin_server_requirement_168_170_attestation_options,
          title: 'Sequentially numbers and properly references diagnosis.sequence',
          description: %(
            I attest that the Health IT Module sequentially numbers all diagnoses at the ExplanationOfBenefit header
              level using the `diagnosis.sequence` element. I further attest that each `item.diagnosisSequence` element
              references the appropriate `diagnosis.sequence` number from the header-level diagnoses.
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
    input :carin_server_requirement_168_170_attestation_note,
          title: 'Notes, if applicable:',
          type: 'textarea',
          optional: true


        run do
          assert carin_server_requirement_168_170_attestation_options == 'true', %(
            The following was not satisfied:

            The Health IT Module sequentially numbers all diagnoses at the ExplanationOfBenefit header
            level using the `diagnosis.sequence` element. I further attest that each `item.diagnosisSequence` element
            references the appropriate `diagnosis.sequence` number from the header-level diagnoses.

          )
          pass carin_server_requirement_168_170_attestation_note if carin_server_requirement_168_170_attestation_note.present?
        end

  end
end
