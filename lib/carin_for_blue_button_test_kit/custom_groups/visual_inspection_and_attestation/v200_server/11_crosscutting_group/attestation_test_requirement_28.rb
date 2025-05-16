module CarinForBlueButtonTestKit
  class AttestationTestCarinV2Requirement28 < Inferno::Test
    title 'Ensures conformant CPCDS data'
    description <<~DESCRIPTION
      The Health IT Module ensures that data representing the Common Payer Consumer Data Set (CPCDS)
      conforms to the specified profiles, vocabulary standards, and code sets required by the specification.
    DESCRIPTION
    id :carin_server_requirement_28_attestation

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@28'

    run do
      identifier = SecureRandom.hex(32)
      wait(
        identifier:,
        message: <<~MESSAGE
          I attest that the Health IT Module ensures CPCDS data conforms to the specified profiles,
          vocabulary standards, and code sets outlined in the specification.

          [Click here](#{resume_pass_url}?token=#{identifier}) if the system **meets** this requirement.  
          [Click here](#{resume_fail_url}?token=#{identifier}) if the system **does not meet** this requirement.
        MESSAGE
      )
    end
  end
end
