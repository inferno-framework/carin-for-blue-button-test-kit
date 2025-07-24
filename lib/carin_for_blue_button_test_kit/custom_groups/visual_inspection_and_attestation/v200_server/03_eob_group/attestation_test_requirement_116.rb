module CarinForBlueButtonTestKit
  class AttestationTestCarinV2Requirement116_117 < Inferno::Test
    title 'Correctly populates EOB.insurer and EOB.outcome'
    description <<~DESCRIPTION
      The Health IT Module:
      - Sets `ExplanationOfBenefit.outcome` to "complete",
      - Sets `ExplanationOfBenefit.insurer` equal to `insurance.coverage.organization`.
    DESCRIPTION
    id :carin_server_requirement_116_117_attestation

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@116',
                          'hl7.fhir.us.carin-bb_2.0.0@117'

    input :carin_server_requirement_116_117_attestation_options,
          title: 'Correctly populates EOB.insurer and EOB.outcome',
          description: %(
            I attest that the Health IT Module:

              - Sets `ExplanationOfBenefit.outcome` to "complete",
              - Populates `ExplanationOfBenefit.insurer` with the same value as `insurance.coverage.organization`.
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
    input :carin_server_requirement_116_117_attestation_note,
          title: 'Notes, if applicable:',
          type: 'textarea',
          optional: true



    run do
      assert carin_server_requirement_116_117_attestation_options == 'true',
             'Client application did not demonstrate correct usage of the authorization code.'
      pass carin_server_requirement_116_117_attestation_note if carin_server_requirement_116_117_attestation_note.present?
    end

  end
end
