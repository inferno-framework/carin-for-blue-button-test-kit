# frozen_string_literal: true

module CarinForBlueButtonTestKit
  class AttestationTestCarinV2Requirement152 < Inferno::Test
    title 'Specifies additional body sites'
    description <<~DESCRIPTION
      Additional body sites (tooth or oral cavity) are specified in `supportingInfo[additionalbodysite]`
      elements, and that each `supportingInfo[additionalbodysite].sequence` matches the associated line item's
      `item.informationSequence`.
    DESCRIPTION
    id :carin_server_requirement_152_attestation

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@152'

    run do
      identifier = SecureRandom.hex(32)
      wait(
        identifier:,
        message: <<~MESSAGE
          I attest that additional body sites (tooth or oral cavity) are specified in `supportingInfo[additionalbodysite]`
          elements, and that each `supportingInfo[additionalbodysite].sequence` matches the associated line item's
          `item.informationSequence`.

          [Click here](#{resume_pass_url}?token=#{identifier}) if the system **meets** this requirement.

          [Click here](#{resume_fail_url}?token=#{identifier}) if the system **does not meet** this requirement.
        MESSAGE
      )
    end
  end
end
