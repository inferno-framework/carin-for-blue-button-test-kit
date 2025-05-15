module CarinForBlueButtonTestKit
  class AttestationTestCarinV2Requirement151 < Inferno::Test
    title 'Specifies primary body site'
    description <<~DESCRIPTION
      The primary body site for each line item (tooth or oral cavity) is specified in the
      `item.bodySite` element of the ExplanationOfBenefit resource.
    DESCRIPTION
    id :carin_server_requirement_151_attestation

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@151'

    run do
      identifier = SecureRandom.hex(32)
      wait(
        identifier:,
        message: <<~MESSAGE
          I attest that the primary body site for each line item (tooth or oral cavity) is specified in the
          `item.bodySite` element of the ExplanationOfBenefit resource.

          [Click here](#{resume_pass_url}?token=#{identifier}) if the system **meets** this requirement.

          [Click here](#{resume_fail_url}?token=#{identifier}) if the system **does not meet** this requirement.
        MESSAGE
      )
    end
  end
end
