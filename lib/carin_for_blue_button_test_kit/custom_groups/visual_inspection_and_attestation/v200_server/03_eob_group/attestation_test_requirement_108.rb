# frozen_string_literal: true

module CarinForBlueButtonTestKit
  class AttestationTestCarinV2Requirement108 < Inferno::Test
    title 'Supports versioned and unversioned references'
    description <<~DESCRIPTION
      The Health IT Module supports both versioned and non-versioned ExplanationOfBenefit
      reference approaches when referencing another resource,
      and returns the same content for referenced resources in either case.
    DESCRIPTION
    id :carin_server_requirement_108_attestation

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@108'

    run do
      identifier = SecureRandom.hex(32)
      wait(
        identifier:,
        message: <<~MESSAGE
          I attest that the Health IT Module supports both versioned and non-versioned ExplanationOfBenefit
          reference approaches when referencing another resource,
          and returns the same content for referenced resources in either case.

          [Click here](#{resume_pass_url}?token=#{identifier}) if the system **meets** this requirement.

          [Click here](#{resume_fail_url}?token=#{identifier}) if the system **does not meet** this requirement.
        MESSAGE
      )
    end
  end
end
