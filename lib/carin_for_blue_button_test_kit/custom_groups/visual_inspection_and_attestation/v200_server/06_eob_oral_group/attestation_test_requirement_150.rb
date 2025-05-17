module CarinForBlueButtonTestKit
  class AttestationTestCarinV2Requirement150 < Inferno::Test
    title 'Uses procedure codes not revenue codes'
    description <<~DESCRIPTION
      The `item.productOrService` element in an oral ExplanationOfBenefit resource
      is populated with CPT or HCPCS procedure codes as CodeableConcept values, and that revenue
      codes are not used for oral claims.
    DESCRIPTION
    id :carin_server_requirement_150_attestation

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@150'

    run do
      identifier = SecureRandom.hex(32)
      wait(
        identifier:,
        message: <<~MESSAGE
          I attest that the `item.productOrService` element in an oral ExplanationOfBenefit resource
          is populated with CPT or HCPCS procedure codes as CodeableConcept values, and that revenue
          codes are not used for oral claims.

          [Click here](#{resume_pass_url}?token=#{identifier}) if the system **meets** this requirement.

          [Click here](#{resume_fail_url}?token=#{identifier}) if the system **does not meet** this requirement.
        MESSAGE
      )
    end
  end
end
