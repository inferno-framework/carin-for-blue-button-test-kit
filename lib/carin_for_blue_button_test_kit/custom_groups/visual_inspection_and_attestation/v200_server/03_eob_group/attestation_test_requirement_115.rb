module CarinForBlueButtonTestKit
  class AttestationTestCarinV2Requirement115 < Inferno::Test
    title 'Does not use a data absent reason for EOB.type'
    description <<~DESCRIPTION
      The Health IT Module does not assign a data absent reason to the `ExplanationOfBenefit.type` element.
    DESCRIPTION
    id :carin_server_requirement_115_attestation

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@115'

    run do
      identifier = SecureRandom.hex(32)
      wait(
        identifier:,
        message: <<~MESSAGE
          I attest that the Health IT Module does **not** assign a data absent reason to `ExplanationOfBenefit.type`.

          [Click here](#{resume_pass_url}?token=#{identifier}) if the system **meets** this requirement.
          [Click here](#{resume_fail_url}?token=#{identifier}) if the system **does not meet** this requirement.
        MESSAGE
      )
    end
  end
end
