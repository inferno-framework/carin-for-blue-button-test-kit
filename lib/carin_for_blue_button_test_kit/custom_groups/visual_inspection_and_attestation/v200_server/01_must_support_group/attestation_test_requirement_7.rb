module CarinForBlueButtonTestKit
  class AttestationTestCarinV2Requirement7 < Inferno::Test
    title 'Includes reason for missing Must Support elements'
    description <<~DESCRIPTION
      When a Must Support element is missing and the reason for the absence is known,
      the Health IT Module includes a reason using either:
      - a value such as a nullFlavor from the relevant value set, or  
      - the `dataAbsentReason` extension.
    DESCRIPTION
    id :carin_server_requirement_7_attestation

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@7'

    run do
      identifier = SecureRandom.hex(32)
      wait(
        identifier:,
        message: <<~MESSAGE
          The developer of the Health IT Module attests that when a Must Support element is missing and the
          reason for the absence is known, the Health IT Module includes a reason using either:
          - a value such as a nullFlavor from the relevant value set, or  
          - the `dataAbsentReason` extension.

          [Click here](#{resume_pass_url}?token=#{identifier}) if the system **meets** this requirement.  
          [Click here](#{resume_fail_url}?token=#{identifier}) if the system **does not meet** this requirement.
        MESSAGE
      )
    end
  end
end
