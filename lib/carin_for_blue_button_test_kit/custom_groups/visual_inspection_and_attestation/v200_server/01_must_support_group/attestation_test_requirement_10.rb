module CarinForBlueButtonTestKit
  class AttestationTestCarinV2Requirement10 < Inferno::Test
    title 'Follows FHIR and US Core guidance when data is unavailable'
    description <<~DESCRIPTION
      The Health IT Module follows the FHIR core specification and US Core guidance when no data is available
      for required data elements (minimum cardinality > 0).
    DESCRIPTION
    id :carin_server_requirement_10_attestation

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@10'

    run do
      identifier = SecureRandom.hex(32)
      wait(
        identifier:,
        message: <<~MESSAGE
          I attest that the Health IT Module applies FHIR and US Core guidance
          when the source system lacks data for required elements with minimum cardinality > 0.

          [Click here](#{resume_pass_url}?token=#{identifier}) if the system **meets** this requirement.

          [Click here](#{resume_fail_url}?token=#{identifier}) if the system **does not meet** this requirement.
        MESSAGE
      )
    end
  end
end
