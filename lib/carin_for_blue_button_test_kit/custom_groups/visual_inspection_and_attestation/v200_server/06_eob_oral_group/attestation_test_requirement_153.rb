# frozen_string_literal: true

module CarinForBlueButtonTestKit
  class AttestationTestCarinV2Requirement153 < Inferno::Test
    title 'Applies oral line item subsites to associated tooth surfaces'
    description <<~DESCRIPTION
      All oral line item subsites (`item.subSite` repetitions) apply to all the line item's
      associated tooth surfaces, including those specified in `item.bodySite` and `supportingInfo[additionalbodysite]`,
      with the association established through matching `supportingInfo[additionalbodysite].sequence` values in
      `item.informationSequence`.
    DESCRIPTION
    id :carin_server_requirement_153_attestation

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@153'

    run do
      identifier = SecureRandom.hex(32)
      wait(
        identifier:,
        message: <<~MESSAGE
          I attest that all oral line item subsites (`item.subSite` repetitions) apply to all the line item's
          associated tooth surfaces, including those specified in `item.bodySite` and `supportingInfo[additionalbodysite]`,
          with the association established through matching `supportingInfo[additionalbodysite].sequence` values in
          `item.informationSequence`.

          [Click here](#{resume_pass_url}?token=#{identifier}) if the system **meets** this requirement.

          [Click here](#{resume_fail_url}?token=#{identifier}) if the system **does not meet** this requirement.
        MESSAGE
      )
    end
  end
end
