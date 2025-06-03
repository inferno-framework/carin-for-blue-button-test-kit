# frozen_string_literal: true

module CarinForBlueButtonTestKit
  class AttestationTestCarinV2Requirement130 < Inferno::Test
    title 'Provides claim amounts if line item amounts unavailable'
    description <<~DESCRIPTION
      If line item amounts are not available, the Health IT Module provides the claim amounts
      and corresponding amount types in the ExplanationOfBenefit (EOB) header data elements, as specified
      by the CPCDS data elements.
    DESCRIPTION
    id :carin_server_requirement_130_attestation

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@130'

    run do
      identifier = SecureRandom.hex(32)
      wait(
        identifier:,
        message: <<~MESSAGE
          I attest that if line item amounts are not available, the Health IT Module provides the claim amounts
          and corresponding amount types in the ExplanationOfBenefit (EOB) header data elements, as specified
          by the CPCDS data elements.

          [Click here](#{resume_pass_url}?token=#{identifier}) if the system **meets** this requirement.

          [Click here](#{resume_fail_url}?token=#{identifier}) if the system **does not meet** this requirement.
        MESSAGE
      )
    end
  end
end
