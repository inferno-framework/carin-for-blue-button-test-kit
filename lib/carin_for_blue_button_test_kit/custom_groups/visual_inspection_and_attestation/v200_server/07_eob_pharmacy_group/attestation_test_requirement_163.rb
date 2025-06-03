# frozen_string_literal: true

module CarinForBlueButtonTestKit
  class AttestationTestCarinV2Requirement163 < Inferno::Test
    title 'Populates with NDC code'
    description <<~DESCRIPTION
      Both `item.productOrService` and `item.detail.productOrService` elements are populated with
      an 11-digit NDC code.
    DESCRIPTION
    id :carin_server_requirement_163_attestation

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@163'

    run do
      identifier = SecureRandom.hex(32)
      wait(
        identifier:,
        message: <<~MESSAGE
          I attest that both `item.productOrService` and `item.detail.productOrService` elements are populated with
          an 11-digit NDC code.

          [Click here](#{resume_pass_url}?token=#{identifier}) if the system **meets** this requirement.

          [Click here](#{resume_fail_url}?token=#{identifier}) if the system **does not meet** this requirement.
        MESSAGE
      )
    end
  end
end
