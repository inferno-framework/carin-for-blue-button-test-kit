module CarinForBlueButtonTestKit
  class AttestationTestCarinV2Requirement178 < Inferno::Test
    title 'Does not populate "address" when part of Billing Provider'
    description <<~DESCRIPTION
      The Health IT Module does not populate the Organization resource `address` element
      when the location where services were rendered is a component of the Billing Provider.
    DESCRIPTION
    id :carin_server_requirement_178_attestation

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@178'

    run do
      identifier = SecureRandom.hex(32)
      wait(
        identifier:,
        message: <<~MESSAGE
          I attest that the Health IT Module does not populate the Organization resource `address` element
          when the location where services were rendered is a component of the Billing Provider.

          [Click here](#{resume_pass_url}?token=#{identifier}) if the system **meets** this requirement.

          [Click here](#{resume_fail_url}?token=#{identifier}) if the system **does not meet** this requirement.
        MESSAGE
      )
    end
  end
end
