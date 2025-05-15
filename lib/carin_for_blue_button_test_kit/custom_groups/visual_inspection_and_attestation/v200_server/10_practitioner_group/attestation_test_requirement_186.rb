module CarinForBlueButtonTestKit
  class AttestationTestCarinV2Requirement186 < Inferno::Test
    title 'Populates an identifier'
    description <<~DESCRIPTION
      The Health IT Module populates the Practitioner resource with at least one identifier,
      either an NPI or a Tax ID.
    DESCRIPTION
    id :carin_server_requirement_186_attestation

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@186'

    run do
      identifier = SecureRandom.hex(32)
      wait(
        identifier:,
        message: <<~MESSAGE
          I attest that the Health IT Module populates the Practitioner resource with at least one identifier,
          either an NPI or a Tax ID.

          [Click here](#{resume_pass_url}?token=#{identifier}) if the system **meets** this requirement.

          [Click here](#{resume_fail_url}?token=#{identifier}) if the system **does not meet** this requirement.
        MESSAGE
      )
    end
  end
end
