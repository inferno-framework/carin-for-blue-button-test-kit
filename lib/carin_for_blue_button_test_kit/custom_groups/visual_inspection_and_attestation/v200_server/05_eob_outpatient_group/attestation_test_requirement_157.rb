module CarinForBlueButtonTestKit
  class AttestationTestCarinV2Requirement157_158_159 < Inferno::Test
    title 'Correctly populates EOB.item.productOrService'
    description <<~DESCRIPTION
      The Health IT Module:
      - Defines CPT, HCPCS, or HIPPS codes in `item.productOrService` as CodeableConcepts,
      - Ensures `item.productOrService` is populated whenever `.item` is present,
      - Enforces a cardinality of 1..1 for `item.productOrService`.
    DESCRIPTION
    id :carin_server_requirement_157_158_159_attestation

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@157',
                          'hl7.fhir.us.carin-bb_2.0.0@158',
                          'hl7.fhir.us.carin-bb_2.0.0@159'

    run do
      identifier = SecureRandom.hex(32)
      wait(
        identifier:,
        message: <<~MESSAGE
          I attest that the Health IT Module:

          - Defines CPT, HCPCS, or HIPPS codes in `item.productOrService` and represents them as CodeableConcepts,
          - Populates `item.productOrService` whenever `EOB.item` is present,
          - Enforces that `item.productOrService` has a cardinality of 1..1.

          [Click here](#{resume_pass_url}?token=#{identifier}) if the system **meets** these requirements.
          [Click here](#{resume_fail_url}?token=#{identifier}) if the system **does not meet** these requirements.
        MESSAGE
      )
    end
  end
end
