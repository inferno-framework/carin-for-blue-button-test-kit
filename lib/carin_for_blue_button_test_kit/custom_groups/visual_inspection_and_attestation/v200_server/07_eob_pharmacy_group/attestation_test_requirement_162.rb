# frozen_string_literal: true

module CarinForBlueButtonTestKit
  class AttestationTestCarinV2Requirement162 < Inferno::Test
    title 'Populates with "compound" and maps correctly'
    description <<~DESCRIPTION
      When the Compound Code is 2, the `item.productOrService` element is populated with the value
      "compound" and that the ingredient information is mapped to `item.detail.productOrService.`
    DESCRIPTION
    id :carin_server_requirement_162_attestation

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@162'

    run do
      identifier = SecureRandom.hex(32)
      wait(
        identifier:,
        message: <<~MESSAGE
          I attest that when the Compound Code is 2, the `item.productOrService` element is populated with the value
          "compound" and that the ingredient information is mapped to `item.detail.productOrService.`

          [Click here](#{resume_pass_url}?token=#{identifier}) if the system **meets** this requirement.

          [Click here](#{resume_fail_url}?token=#{identifier}) if the system **does not meet** this requirement.
        MESSAGE
      )
    end
  end
end
