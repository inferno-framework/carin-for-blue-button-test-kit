module CarinForBlueButtonTestKit
  class AttestationTestCarinV2Requirement115 < Inferno::Test
    title 'Does not use a data absent reason for EOB.type'
    description <<~DESCRIPTION
      The Health IT Module does not assign a data absent reason to the `ExplanationOfBenefit.type` element.
    DESCRIPTION
    id :carin_server_requirement_115_attestation

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@115'

    input :carin_server_requirement_115_attestation_options,
          title: 'Does not use a data absent reason for EOB.type',
          description: %(
            I attest that the Health IT Module does **not** assign a data absent reason to `ExplanationOfBenefit.type`.
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
    input :carin_server_requirement_115_attestation_note,
          title: 'Notes, if applicable:',
          type: 'textarea',
          optional: true


        run do
          assert carin_server_requirement_115_attestation_options == 'true', %(
            The following was not satisfied:

            The Health IT Module does not assign a data absent reason to the `ExplanationOfBenefit.type` element.

          )
          pass carin_server_requirement_115_attestation_note if carin_server_requirement_115_attestation_note.present?
        end

  end
end
