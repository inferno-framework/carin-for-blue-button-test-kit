module CarinForBlueButtonTestKit
  class AttestationTestCarinV2Requirement19 < Inferno::Test
    title 'Uses code display string'
    description <<~DESCRIPTION
      The Health IT Module ensures that when the `display` element is populated,
      it contains one of the display strings defined for the associated code
      in the code system.
    DESCRIPTION
    id :carin_server_requirement_19_attestation

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@19'

    run do
      identifier = SecureRandom.hex(32)
      wait(
        identifier:,
        message: <<~MESSAGE
          I attest that when the `display` element is populated, the Health IT Module uses a valid display string defined
          for that code by the code system (which may allow multiple valid display strings).

          [Click here](#{resume_pass_url}?token=#{identifier}) if the system **meets** this requirement.

          [Click here](#{resume_fail_url}?token=#{identifier}) if the system **does not meet** this requirement.
        MESSAGE
      )
    end
  end
end
