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

    run do
      identifier = SecureRandom.hex(32)
      wait(
        identifier:,
        message: <<~MESSAGE
          I attest that when an ExplanationOfBenefit resource returned by the Health IT Module
          has been adjusted by another ExplanationOfBenefit,
          the `.related.reference` field is populated with the identifier of the adjusting ExplanationOfBenefit,
          and the `.related.relationship` field is assigned the value `replacedby`.

          [Click here](#{resume_pass_url}?token=#{identifier}) if the system **meets** this requirement.

          [Click here](#{resume_fail_url}?token=#{identifier}) if the system **does not meet** this requirement.
        MESSAGE
      )
    end
  end
end
