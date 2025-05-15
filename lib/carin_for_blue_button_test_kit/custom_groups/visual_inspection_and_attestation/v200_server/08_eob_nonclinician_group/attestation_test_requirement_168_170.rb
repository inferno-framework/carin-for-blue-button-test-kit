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

    run do
      identifier = SecureRandom.hex(32)
      wait(
        identifier:,
        message: <<~MESSAGE
          I attest that the Health IT Module sequentially numbers all diagnoses at the ExplanationOfBenefit header
          level using the `diagnosis.sequence` element. I further attest that each `item.diagnosisSequence` element
          references the appropriate `diagnosis.sequence` number from the header-level diagnoses.

          [Click here](#{resume_pass_url}?token=#{identifier}) if the system **meets** this requirement.

          [Click here](#{resume_fail_url}?token=#{identifier}) if the system **does not meet** this requirement.
        MESSAGE
      )
    end
  end
end
