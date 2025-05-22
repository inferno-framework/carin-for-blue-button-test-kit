module CarinForBlueButtonTestKit
  class AttestationTestCarinV2Requirement149 < Inferno::Test
    title 'References sequence number of associated diagnosis'
    description <<~DESCRIPTION
      The `item.diagnosisSequence` element references the sequence number of the associated
      diagnosis listed in the ExplanationOfBenefit resource.
    DESCRIPTION
    id :carin_server_requirement_149_attestation

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@149'

    run do
      identifier = SecureRandom.hex(32)
      wait(
        identifier:,
        message: <<~MESSAGE
          I attest that the `item.diagnosisSequence` element references the sequence number of the associated
          diagnosis listed in the ExplanationOfBenefit resource.

          [Click here](#{resume_pass_url}?token=#{identifier}) if the system **meets** this requirement.

          [Click here](#{resume_fail_url}?token=#{identifier}) if the system **does not meet** this requirement.
        MESSAGE
      )
    end
  end
end
