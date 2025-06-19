module CarinForBlueButtonTestKit
  class AttestationTestCarinV2Requirement2 < Inferno::Test
    title 'Returns maintained data'
    description <<~DESCRIPTION
      The Health IT Module is capable of populating and returning all data elements maintained
      by the payer as part of the query results, as specified by the CARIN Blue Button Health Plan API
      CapabilityStatement.
    DESCRIPTION
    id :carin_server_requirement_2_attestation

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@2'

    run do
      identifier = SecureRandom.hex(32)
      wait(
        identifier:,
        message: <<~MESSAGE
          I attest that the Health IT Module is capable of populating and returning all data elements maintained
          by the payer as part of the query results, as specified by the CARIN Blue Button Health Plan API
          CapabilityStatement.

          [Click here](#{resume_pass_url}?token=#{identifier}) if the system **meets** this requirement.

          [Click here](#{resume_fail_url}?token=#{identifier}) if the system **does not meet** this requirement.
        MESSAGE
      )
    end
  end
end
