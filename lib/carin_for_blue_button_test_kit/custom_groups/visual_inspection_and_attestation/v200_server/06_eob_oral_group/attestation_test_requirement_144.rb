module CarinForBlueButtonTestKit
  class AttestationTestCarinV2Requirement144_145_146 < Inferno::Test
    title 'Correctly maps CPCDS data to EOB.item and EOB.total fields'
    description <<~DESCRIPTION
      The Health IT Module maps CPCDS data elements to:
      - `EOB.item` for line item amounts, amount types, and network status,
      - `EOB.total` for claim-level totals,
      - `C4BB Payer Benefit Payment Status` is set to 'Other' when lines are both in-network and out-of-network.
    DESCRIPTION
    id :carin_server_requirement_144_145_146_attestation

    verifies_requirements(
      'hl7.fhir.us.carin-bb_2.0.0@144',
      'hl7.fhir.us.carin-bb_2.0.0@145',
      'hl7.fhir.us.carin-bb_2.0.0@146'
    )

    run do
      identifier = SecureRandom.hex(32)
      wait(
        identifier:,
        message: <<~MESSAGE
          I attest that the Health IT Module maps CPCDS data elements as follows:

          - Line-level data (amounts, types, network status) are provided in `EOB.item`,
          - Claim-level totals are in `EOB.total`,
          - Mixed network claims set `C4BB Payer Benefit Payment Status` to 'Other'.

          [Click here](#{resume_pass_url}?token=#{identifier}) if the system **meets** this requirement.
          [Click here](#{resume_fail_url}?token=#{identifier}) if the system **does not meet** this requirement.
        MESSAGE
      )
    end
  end
end
