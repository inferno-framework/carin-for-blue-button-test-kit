module CarinForBlueButtonTestKit
  class CARIN4BBLastUpdatedTest < Inferno::Test
    title 'Uses meta.lastUpdated value appropriately'
    description <<~DESCRIPTION
      The Health IT Module must use the meta.lastUpdated value to determine if the associated data is
      accurate as of the date of service or as of the current date.
    DESCRIPTION
    id :c4bb_last_updated

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@90', 'hl7.fhir.us.carin-bb_2.0.0@180',
                          'hl7.fhir.us.carin-bb_2.0.0@188'

    run do
      identifier = SecureRandom.hex(32)
      wait(
        identifier:,
        message: <<~MESSAGE
          The developer of the Health IT Module attests that the Health IT Module used the
          meta.lastUpdated value to determine if the associated data is accurate as of the date of service or as of the current date.

          [Click here](#{resume_pass_url}?token=#{identifier}) if the tester visually confirmed system **meets** this requirement.

          [Click here](#{resume_fail_url}?token=#{identifier}) if the tester visually confirmed system **does not meet** this requirement.
        MESSAGE
      )
    end
  end
end
