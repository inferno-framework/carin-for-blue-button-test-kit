# frozen_string_literal: true

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

    run do
      identifier = SecureRandom.hex(32)
      wait(
        identifier:,
        message: <<~MESSAGE
          I attest that when an ExplanationOfBenefit resource returned by the Health IT Module
          adjusts a prior ExplanationOfBenefit, the `.related.reference`
          field is populated with the identifier of the prior ExplanationOfBenefit, and the `.related.relationship` field
          is assigned the value `prior`.

          [Click here](#{resume_pass_url}?token=#{identifier}) if the system **meets** this requirement.

          [Click here](#{resume_fail_url}?token=#{identifier}) if the system **does not meet** this requirement.
        MESSAGE
      )
    end
  end
end
