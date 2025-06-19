module CarinForBlueButtonTestKit
  class AttestationTestCarinV2Requirement156 < Inferno::Test
    title 'Maps CPCDS data when line item data is unavailable'
    description <<~DESCRIPTION
      The Health IT Module maps CPCDS data to either `EOB.item` or `EOB.header` as appropriate:
          - When line item amounts are available, they are provided in `EOB.item`.
          - When line item amounts are not available, claim-level amounts and amount types are provided in `EOB.header`.
    DESCRIPTION
    id :carin_server_requirement_156_attestation

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@156'

    run do
      identifier = SecureRandom.hex(32)
      wait(
        identifier:,
        message: <<~MESSAGE
          I attest that the Health IT Module maps CPCDS data to either `EOB.item` or `EOB.header` as appropriate:
          - When line item amounts are available, they are provided in `EOB.item`.
          - When line item amounts are not available, claim-level amounts and amount types are provided in `EOB.header`.

          [Click here](#{resume_pass_url}?token=#{identifier}) if the system **meets** this requirement.
          [Click here](#{resume_fail_url}?token=#{identifier}) if the system **does not meet** this requirement.
        MESSAGE
      )
    end
  end
end
