module CarinForBlueButtonTestKit
  class CARIN4BBMustSupportRetainTest < Inferno::Test
    title 'Retains required and Must Support data elements'
    description <<~DESCRIPTION
      The Health IT Module must retain all required and Must Support data elements.
    DESCRIPTION
    id :c4bb_must_support_retain

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@13'

    run do
      identifier = SecureRandom.hex(32)
      wait(
        identifier:,
        message: <<~MESSAGE
          The developer of the Health IT Module attests that the Health IT Module retained all required
          and Must Support data elements for the requested CARIN IG for Blue Button® resource instances.

          [Click here](#{resume_pass_url}?token=#{identifier}) if the tester visually confirmed system **meets** this requirement.

          [Click here](#{resume_fail_url}?token=#{identifier}) if the tester visually confirmed system **does not meet** this requirement.
        MESSAGE
      )
    end
  end
end
