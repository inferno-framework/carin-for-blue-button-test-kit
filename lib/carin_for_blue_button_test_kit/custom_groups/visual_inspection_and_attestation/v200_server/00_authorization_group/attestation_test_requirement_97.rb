module CarinForBlueButtonTestKit
  class AttestationTestCarinV2Requirement97 < Inferno::Test
    title 'Responds with appropriate error codes'
    description <<~DESCRIPTION
      The Health IT Module returns the following response classes:
      - (Status 400): invalid parameter
      - (Status 401/4xx): unauthorized request
      - (Status 403): insufficient scope
      - (Status 404): unknown resource
      - (Status 410): deleted resource.

      The Health IT Module rejects any unauthorized request by returning an HTTP 401 "Unauthorized", HTTP 403 "Forbidden",
      or HTTP 404 "Not Found" .
    DESCRIPTION
    id :carin_server_requirement_97_attestation

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@97', 'hl7.fhir.us.carin-bb_2.0.0@102'

    run do
      identifier = SecureRandom.hex(32)
      wait(
        identifier:,
        message: <<~MESSAGE
          I attest that the Health IT Module returns the following response classes:
          - (Status 400): invalid parameter
          - (Status 401/4xx): unauthorized request
          - (Status 403): insufficient scope
          - (Status 404): unknown resource
          - (Status 410): deleted resource.

          I further attest that the Health IT Module rejects any unauthorized request by returning an HTTP 401 "Unauthorized",
          HTTP 403 "Forbidden", or HTTP 404 "Not Found" .

          [Click here](#{resume_pass_url}?token=#{identifier}) if the system **meets** these requirements.

          [Click here](#{resume_fail_url}?token=#{identifier}) if the system **does not meet** these requirements.
        MESSAGE
      )
    end
  end
end
