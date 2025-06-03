# frozen_string_literal: true

module CarinForBlueButtonTestKit
  class AttestationTestCarinV2Requirement48_57 < Inferno::Test
    title 'Secures data'
    description <<~DESCRIPTION
      The Health IT Module
      - Enables members to direct the communication of CARIN4BB data through authenticated, authorized, and secure channels.
      - Protects CARIN4BB data with proper security and privacy protections to avoid malicious or unintentional exposure of
        such information.
      - Secures all consumer-directed payer data exchanges in transit and limits access only to authorized individuals.
      - Ensures that APIs fully and successfully implement privacy and security features such as, but not limited to, those
        required to comply with HIPAA privacy and security requirements and other applicable law protecting the privacy and
        security of protected health information.
      - Uses either current or the immediately prior release of Transport Level Security (TLS) as specified by the current release
        of NIST guidelines (SP 800-52).
      - Supports the FHIR US Core [Patient Privacy and Security requirements](https://www.hl7.org/fhir/us/core/security.html).
    DESCRIPTION
    id :carin_server_requirement_48_57_attestation

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@48',
                          'hl7.fhir.us.carin-bb_2.0.0@49',
                          'hl7.fhir.us.carin-bb_2.0.0@50',
                          'hl7.fhir.us.carin-bb_2.0.0@51',
                          'hl7.fhir.us.carin-bb_2.0.0@55',
                          'hl7.fhir.us.carin-bb_2.0.0@57'

    run do
      identifier = SecureRandom.hex(32)
      wait(
        identifier:,
        message: <<~MESSAGE
          I attest that the Health IT Module
          - Enables members to direct the communication of CARIN4BB data through authenticated, authorized, and secure channels.
          - Protects CARIN4BB data with proper security and privacy protections to avoid malicious or unintentional exposure of
            such information.
          - Secures all consumer-directed payer data exchanges in transit and limits access only to authorized individuals.
          - Ensures that APIs fully and successfully implement privacy and security features such as, but not limited to, those
            required to comply with HIPAA privacy and security requirements and other applicable law protecting the privacy and
            security of protected health information.
          - Uses either current or the immediately prior release of Transport Level Security (TLS) as specified by the current release
            of NIST guidelines (SP 800-52).
          - Supports the FHIR US Core [Patient Privacy and Security requirements](https://www.hl7.org/fhir/us/core/security.html).

          [Click here](#{resume_pass_url}?token=#{identifier}) if the system **meets** these requirements.

          [Click here](#{resume_fail_url}?token=#{identifier}) if the system **does not meet** these requirements.
        MESSAGE
      )
    end
  end
end
