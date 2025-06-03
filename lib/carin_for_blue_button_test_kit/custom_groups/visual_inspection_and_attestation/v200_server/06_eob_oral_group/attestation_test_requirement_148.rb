# frozen_string_literal: true

module CarinForBlueButtonTestKit
  class AttestationTestCarinV2Requirement148 < Inferno::Test
    title 'Populates facility information when differs from billing'
    description <<~DESCRIPTION
      The Health Plan API populates `supportingInfo[service`facility`] with the name, full address,
      and identifier of the facility where services were rendered, when that facility differs from the Billing or
      Rendering Provider.
    DESCRIPTION
    id :carin_server_requirement_148_attestation

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@148'

    run do
      identifier = SecureRandom.hex(32)
      wait(
        identifier:,
        message: <<~MESSAGE
          I attest that the Health Plan API populates `supportingInfo[service`facility`] with the name, full address,
          and identifier of the facility where services were rendered, when that facility differs from the Billing or
          Rendering Provider.

          [Click here](#{resume_pass_url}?token=#{identifier}) if the system **meets** this requirement.

          [Click here](#{resume_fail_url}?token=#{identifier}) if the system **does not meet** this requirement.
        MESSAGE
      )
    end
  end
end
