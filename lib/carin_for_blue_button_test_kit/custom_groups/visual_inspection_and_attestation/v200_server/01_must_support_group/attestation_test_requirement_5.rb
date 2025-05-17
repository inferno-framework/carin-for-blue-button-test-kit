module CarinForBlueButtonTestKit
  class AttestationTestCarinV2Requirement5 < Inferno::Test
    title 'Does not include absent data with unknown reason'
    description <<~DESCRIPTION
      In situations where information for a particular data element is not present and
      the reason for its absence is unknown, the Health IT Module does not include the data element in
      the resource instance returned as part of the query results.
    DESCRIPTION
    id :carin_server_requirement_5_attestation

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@5'

    run do
      identifier = SecureRandom.hex(32)
      wait(
        identifier:,
        message: <<~MESSAGE
          I attest that in situations where information for a particular data element is not present and
          the reason for its absence is unknown, the Health IT Module does not include the data element in
          the resource instance returned as part of the query results.

          [Click here](#{resume_pass_url}?token=#{identifier}) if the system **meets** this requirement.

          [Click here](#{resume_fail_url}?token=#{identifier}) if the system **does not meet** this requirement.
        MESSAGE
      )
    end
  end
end
