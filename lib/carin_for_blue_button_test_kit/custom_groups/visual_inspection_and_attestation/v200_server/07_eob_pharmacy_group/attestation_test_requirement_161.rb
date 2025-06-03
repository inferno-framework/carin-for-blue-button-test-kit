# frozen_string_literal: true

module CarinForBlueButtonTestKit
  class AttestationTestCarinV2Requirement161 < Inferno::Test
    title 'Populates with an NDC code'
    description <<~DESCRIPTION
      When the Compound Code (MapID 78) is 0 or 1, the `item.productOrService` element is
      populated with an NDC code.
    DESCRIPTION
    id :carin_server_requirement_161_attestation

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@161'

    run do
      identifier = SecureRandom.hex(32)
      wait(
        identifier:,
        message: <<~MESSAGE
          I attest that when the Compound Code (MapID 78) is 0 or 1, the `item.productOrService` element is
          populated with an NDC code.

          [Click here](#{resume_pass_url}?token=#{identifier}) if the system **meets** this requirement.

          [Click here](#{resume_fail_url}?token=#{identifier}) if the system **does not meet** this requirement.
        MESSAGE
      )
    end
  end
end
