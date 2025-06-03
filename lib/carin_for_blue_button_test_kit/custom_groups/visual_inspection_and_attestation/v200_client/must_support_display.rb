# frozen_string_literal: true

module CarinForBlueButtonTestKit
  class CARIN4BBMustSupportDisplayTest < Inferno::Test
    title 'Can display Must Support data elements'
    description <<~DESCRIPTION
      The Health IT Module must be capable of displaying all Must Support data elements.
    DESCRIPTION
    id :c4bb_must_support_display

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@4'

    run do
      identifier = SecureRandom.hex(32)
      wait(
        identifier:,
        message: <<~MESSAGE
          The developer of the Health IT Module attests that the Health IT Module can display all
          Must Support data elements for human use.

          [Click here](#{resume_pass_url}?token=#{identifier}) if the tester visually confirmed system **meets** this requirement.

          [Click here](#{resume_fail_url}?token=#{identifier}) if the tester visually confirmed system **does not meet** this requirement.
        MESSAGE
      )
    end
  end
end
