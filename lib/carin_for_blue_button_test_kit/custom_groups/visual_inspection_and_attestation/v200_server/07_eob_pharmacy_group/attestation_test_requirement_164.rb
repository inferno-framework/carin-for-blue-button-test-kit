module CarinForBlueButtonTestKit
  class AttestationTestCarinV2Requirement164 < Inferno::Test
    title 'Populates "quantity" for all compound code values'
    description <<~DESCRIPTION
      The `item.quantity` element is populated for all Compound Code values.
    DESCRIPTION
    id :carin_server_requirement_164_attestation

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@164'

    run do
      identifier = SecureRandom.hex(32)
      wait(
        identifier:,
        message: <<~MESSAGE
          I attest that the `item.quantity` element is populated for all Compound Code values.

          [Click here](#{resume_pass_url}?token=#{identifier}) if the system **meets** this requirement.

          [Click here](#{resume_fail_url}?token=#{identifier}) if the system **does not meet** this requirement.
        MESSAGE
      )
    end
  end
end
