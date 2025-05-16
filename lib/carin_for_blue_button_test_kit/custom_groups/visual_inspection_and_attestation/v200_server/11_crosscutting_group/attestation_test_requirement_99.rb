module CarinForBlueButtonTestKit
  class AttestationTestCarinV2Requirement99 < Inferno::Test
    title 'Lists CARIN-BB profiles in the meta.profile of each resource'
    description <<~DESCRIPTION
      The Health IT Module includes the appropriate CARIN-BB profile URL(s) in the `meta.profile` field
      of each FHIR resource instance it returns.
    DESCRIPTION
    id :carin_server_requirement_99_attestation

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@99'

    run do
      identifier = SecureRandom.hex(32)
      wait(
        identifier:,
        message: <<~MESSAGE
          I attest that each FHIR resource returned by the Health IT Module includes the appropriate
          CARIN-BB profile URL(s) in the `meta.profile` element.

          [Click here](#{resume_pass_url}?token=#{identifier}) if the system **meets** this requirement.  
          [Click here](#{resume_fail_url}?token=#{identifier}) if the system **does not meet** this requirement.
        MESSAGE
      )
    end
  end
end
