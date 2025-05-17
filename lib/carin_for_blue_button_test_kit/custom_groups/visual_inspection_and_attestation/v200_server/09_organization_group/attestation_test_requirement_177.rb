module CarinForBlueButtonTestKit
  class AttestationTestCarinV2Requirement177 < Inferno::Test
    title 'Properly populates the NPI identifier'
    description <<~DESCRIPTION
      The Health IT Module populates the Service Facility `identifier[NPI]` in the
      Organization resource when assigned, and uses the value 'NPI has not been assigned' when no
      NPI has been assigned to the Service Location Organization.
    DESCRIPTION
    id :carin_server_requirement_177_attestation

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@177'

    run do
      identifier = SecureRandom.hex(32)
      wait(
        identifier:,
        message: <<~MESSAGE
          I attest that the Health IT Module populates the Service Facility `identifier[NPI]` in the
          Organization resource when assigned, and uses the value 'NPI has not been assigned' when no
          NPI has been assigned to the Service Location Organization.

          [Click here](#{resume_pass_url}?token=#{identifier}) if the system **meets** this requirement.

          [Click here](#{resume_fail_url}?token=#{identifier}) if the system **does not meet** this requirement.
        MESSAGE
      )
    end
  end
end
