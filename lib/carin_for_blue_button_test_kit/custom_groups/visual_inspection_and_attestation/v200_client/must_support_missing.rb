module CarinForBlueButtonTestKit
  class CARIN4BBMustSupportMissingTest < Inferno::Test
    title 'Interprets missing Must Support data elements'
    description <<~DESCRIPTION
      The Health IT Module behaving as a client must interpret missing Must Support data elements within resource instances as
      data not present in the Health Plan API actors system.
    DESCRIPTION
    id :c4bb_must_support_missing

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@6'

    run do
      identifier = SecureRandom.hex(32)
      wait(
        identifier:,
        message: <<~MESSAGE
          The developer of the Health IT Module attests that the Health IT Module behaving as a client interpreted missing Must Support
          data elements within resource instances as data not present in the Health Plan API actors system.

          [Click here](#{resume_pass_url}?token=#{identifier}) if the tester visually confirmed system **meets** this requirement.

          [Click here](#{resume_fail_url}?token=#{identifier}) if the tester visually confirmed system **does not meet** this requirement.
        MESSAGE
      )
    end
  end
end
