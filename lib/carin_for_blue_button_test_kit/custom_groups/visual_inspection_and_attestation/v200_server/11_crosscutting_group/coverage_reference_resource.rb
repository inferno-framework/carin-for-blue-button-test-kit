module CarinForBlueButtonTestKit
  class CoverageReferenceResourceTest < Inferno::Test
    title 'Returns Coverage Reference Resource with correct data'

    description <<~DESCRIPTION
      The Health IT Module returns the Coverage Reference Resource with data that was effective as of the date of service of the claim.#{' '}
      For example, the data will reflect the employer name in effect at that time.
    DESCRIPTION

    id :coverage_reference_resource

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@87',
                          'hl7.fhir.us.carin-bb_2.0.0@91',
                          'hl7.fhir.us.carin-bb_2.0.0@175'

    run do
      identifier = SecureRandom.hex(32)

      wait(
        identifier:,
        message: <<~MESSAGE
          I attest that the Health IT Module returns the Coverage Reference Resource with data that was effective as of the date of service of the claim.

          [Click here](#{resume_pass_url}?token=#{identifier}) if the system **meets** these requirements.

          [Click here](#{resume_fail_url}?token=#{identifier}) if the system **does not meet** these requirements.
        MESSAGE
      )
    end
  end
end
