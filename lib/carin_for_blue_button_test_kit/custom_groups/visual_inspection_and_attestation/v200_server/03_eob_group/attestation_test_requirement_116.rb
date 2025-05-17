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

    run do
      identifier = SecureRandom.hex(32)
      wait(
        identifier:,
        message: <<~MESSAGE
          I attest that the Health IT Module:

          - Sets `ExplanationOfBenefit.outcome` to "complete",
          - Populates `ExplanationOfBenefit.insurer` with the same value as `insurance.coverage.organization`.

          [Click here](#{resume_pass_url}?token=#{identifier}) if the system **meets** these requirements.
          [Click here](#{resume_fail_url}?token=#{identifier}) if the system **does not meet** these requirements.
        MESSAGE
      )
    end
  end
end
