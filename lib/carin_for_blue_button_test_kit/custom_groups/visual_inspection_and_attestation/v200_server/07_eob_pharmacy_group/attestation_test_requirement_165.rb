module CarinForBlueButtonTestKit
  class AttestationTestCarinV2Requirement165 < Inferno::Test
    title 'Adds ingredient quantity information'
    description <<~DESCRIPTION
      When the Compound Code is 2, and ingredient quantity information is available,
      it is mapped to `item.detail.quantity`.
    DESCRIPTION
    id :carin_server_requirement_165_attestation

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@165'

    run do
      identifier = SecureRandom.hex(32)
      wait(
        identifier:,
        message: <<~MESSAGE
          I attest that when the Compound Code is 2, and ingredient quantity information is available,
          it is mapped to `item.detail.quantity`.

          [Click here](#{resume_pass_url}?token=#{identifier}) if the system **meets** this requirement.

          [Click here](#{resume_fail_url}?token=#{identifier}) if the system **does not meet** this requirement.
        MESSAGE
      )
    end
  end
end
