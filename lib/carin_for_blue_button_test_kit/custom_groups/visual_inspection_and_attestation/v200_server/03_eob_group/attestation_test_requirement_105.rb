module CarinForBlueButtonTestKit
  class AttestationTestCarinV2Requirement105 < Inferno::Test
    title 'Uses versioned references when point-in-time data is maintained'
    description <<~DESCRIPTION
      The Health IT Module uses versioned references when an ExplanationOfBenefit
      references another resource whenever point-in-time data is maintained, reflecting the data
      effective as of the date of service or admission on the claim.
    DESCRIPTION
    id :carin_server_requirement_105_attestation

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@105'

    run do
      identifier = SecureRandom.hex(32)
      wait(
        identifier:,
        message: <<~MESSAGE
          I attest that the Health IT Module uses versioned references when an ExplanationOfBenefit
          references another resource whenever point-in-time data is maintained, reflecting the data
          effective as of the date of service or admission on the claim.

          [Click here](#{resume_pass_url}?token=#{identifier}) if the system **meets** this requirement.

          [Click here](#{resume_fail_url}?token=#{identifier}) if the system **does not meet** this requirement.
        MESSAGE
      )
    end
  end
end
