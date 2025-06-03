# frozen_string_literal: true

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

    run do
      identifier = SecureRandom.hex(32)
      wait(
        identifier:,
        message: <<~MESSAGE
          I attest that the `.related.reference` field in an ExplanationOfBenefit resource
          returned by the Health IT Module contains the identifier
          of the immediately preceding or following ExplanationOfBenefit, and not the first or last in a sequence.

          [Click here](#{resume_pass_url}?token=#{identifier}) if the system **meets** this requirement.

          [Click here](#{resume_fail_url}?token=#{identifier}) if the system **does not meet** this requirement.
        MESSAGE
      )
    end
  end
end
