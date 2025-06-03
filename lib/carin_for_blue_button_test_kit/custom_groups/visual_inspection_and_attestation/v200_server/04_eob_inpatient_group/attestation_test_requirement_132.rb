# frozen_string_literal: true

module CarinForBlueButtonTestKit
  class AttestationTestCarinV2Requirement132 < Inferno::Test
    title 'Includes in-network or out-of-network payment status'
    description <<~DESCRIPTION
      The Health IT Module includes the in-network or out-of-network payment status of the
      claim within the `EOB.supportingInfo` element, as specified by the CPCDS data elements.
    DESCRIPTION
    id :carin_server_requirement_132_attestation

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@132'

    run do
      identifier = SecureRandom.hex(32)
      wait(
        identifier:,
        message: <<~MESSAGE
          I attest that the Health IT Module includes the in-network or out-of-network payment status of the
          claim within the `EOB.supportingInfo` element, as specified by the CPCDS data elements.

          [Click here](#{resume_pass_url}?token=#{identifier}) if the system **meets** this requirement.

          [Click here](#{resume_fail_url}?token=#{identifier}) if the system **does not meet** this requirement.
        MESSAGE
      )
    end
  end
end
