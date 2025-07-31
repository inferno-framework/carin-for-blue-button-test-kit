module CarinForBlueButtonTestKit
  class AttestationTestCarinV2Requirement124_125_127_128_129 < Inferno::Test
    title 'Correctly populates EOB.insurance'
    description <<~DESCRIPTION
      The Health IT Module:
      - Only assigns `True` to `.insurance.focal` when the insurance matches the `ExplanationOfBenefit.insurer`,
      - Ensures that when `focal = true`, `Coverage.payor` is the same as `EOB.insurer`,
      - When `focal = true`, sets `Coverage.payor` to an Organization identifier,
      - When `focal = false`, sets `insurance.coverage.display` to the name of the other carrier,
      - Populates `insurance.coverage` the same as `insurance.coverage.organization`.
    DESCRIPTION
    id :carin_server_requirement_124_125_127_128_129_attestation

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@124',
                          'hl7.fhir.us.carin-bb_2.0.0@125',
                          'hl7.fhir.us.carin-bb_2.0.0@127',
                          'hl7.fhir.us.carin-bb_2.0.0@128',
                          'hl7.fhir.us.carin-bb_2.0.0@129'

    input :carin_server_requirement_124_125_127_128_129_attestation_options,
          title: 'Correctly populates EOB.insurance',
          description: %(
            I attest that the Health IT Module:

              - Assigns `.insurance.focal = true` only for entries that match `ExplanationOfBenefit.insurer`,
              - When `focal = true`, `Coverage.payor` equals `EOB.insurer` and is represented by an Organization identifier,
              - When `focal = false`, `insurance.coverage.display` is set to the name of the other carrier,
              - Populates `insurance.coverage` the same as `insurance.coverage.organization`.
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
    input :carin_server_requirement_124_125_127_128_129_attestation_note,
          title: 'Notes, if applicable:',
          type: 'textarea',
          optional: true

    run do
      assert carin_server_requirement_124_125_127_128_129_attestation_options == 'true', %(
        The following was not satisfied:

          The Health IT Module:
          - Only assigns `True` to `.insurance.focal` when the insurance matches the `ExplanationOfBenefit.insurer`,
          - Ensures that when `focal = true`, `Coverage.payor` is the same as `EOB.insurer`,
          - When `focal = true`, sets `Coverage.payor` to an Organization identifier,
          - When `focal = false`, sets `insurance.coverage.display` to the name of the other carrier,
          - Populates `insurance.coverage` the same as `insurance.coverage.organization`.

      )
      pass carin_server_requirement_124_125_127_128_129_attestation_note if carin_server_requirement_124_125_127_128_129_attestation_note.present?
    end

  end
end
