module CarinForBlueButtonTestKit
  class AttestationTestCarinV2Requirement9 < Inferno::Test
    title 'Omits Must Support elements with cardinality >= 0 if data is not present'
    description <<~DESCRIPTION
      The Health IT Module omits `Must Support` data elements from the resource if the element's minimum
      cardinality is 0 and no data is available from the source system.
    DESCRIPTION
    id :carin_server_requirement_9_attestation

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@9'

    run do
      identifier = SecureRandom.hex(32)
      wait(
        identifier:,
        message: <<~MESSAGE
          I attest that the Health IT Module omits `Must Support` elements with minimum cardinality = 0
          when the source system has no data available for them.

          [Click here](#{resume_pass_url}?token=#{identifier}) if the system **meets** this requirement.

          [Click here](#{resume_fail_url}?token=#{identifier}) if the system **does not meet** this requirement.
        MESSAGE
      )
    end
  end
end
