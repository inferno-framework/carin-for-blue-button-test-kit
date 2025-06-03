# frozen_string_literal: true

module CarinForBlueButtonTestKit
  class AttestationTestCarinV2Requirement173 < Inferno::Test
    title 'Associates supportingInfo with line items'
    description <<~DESCRIPTION
      Every `supportingInfo` repetition with a Transportation Services Category code is associated
      with at least one ExplanationOfBenefit line item by referencing `supportingInfo.sequence` through the
      `item.informationSequence` element.
    DESCRIPTION
    id :carin_server_requirement_173_attestation

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@173'

    run do
      identifier = SecureRandom.hex(32)
      wait(
        identifier:,
        message: <<~MESSAGE
          I attest that every `supportingInfo` repetition with a Transportation Services Category code is associated
          with at least one ExplanationOfBenefit line item by referencing `supportingInfo.sequence` through the
          `item.informationSequence` element.

          [Click here](#{resume_pass_url}?token=#{identifier}) if the system **meets** this requirement.

          [Click here](#{resume_fail_url}?token=#{identifier}) if the system **does not meet** this requirement.
        MESSAGE
      )
    end
  end
end
