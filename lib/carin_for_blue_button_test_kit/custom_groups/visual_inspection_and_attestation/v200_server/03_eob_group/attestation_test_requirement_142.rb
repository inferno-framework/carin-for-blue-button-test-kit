module CarinForBlueButtonTestKit
  class AttestationTestCarinV2Requirement142_197 < Inferno::Test
    title 'Uses adjudication.amount when item.adjudication is missing'
    description <<~DESCRIPTION
      The Health IT Module populates `adjudication.amount` only when `item.adjudication` is not available.
    DESCRIPTION
    id :carin_server_requirement_142_197_attestation

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@142', 'hl7.fhir.us.carin-bb_2.0.0@197'

    run do
      identifier = SecureRandom.hex(32)
      wait(
        identifier:,
        message: <<~MESSAGE
          I attest that the Health IT Module populates `adjudication.amount` only when `item.adjudication`
          is not available.

          [Click here](#{resume_pass_url}?token=#{identifier}) if the system **meets** these requirements.
          [Click here](#{resume_fail_url}?token=#{identifier}) if the system **does not meet** these requirements.
        MESSAGE
      )
    end
  end
end
