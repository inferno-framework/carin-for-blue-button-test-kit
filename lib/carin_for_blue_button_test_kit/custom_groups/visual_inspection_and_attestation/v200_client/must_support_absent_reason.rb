module CarinForBlueButtonTestKit
  class CARIN4BBMustSupportAbsentReasonTest < Inferno::Test
    title 'Processes Must Support elements that assert missing information'
    description <<~DESCRIPTION
      The Health IT Module must process Must Support elements that assert missing information.
    DESCRIPTION
    id :c4bb_must_support_absent_reason

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@8'

    run do
      identifier = SecureRandom.hex(32)
      wait(
        identifier:,
        message: <<~MESSAGE
          The developer of the Health IT Module attests that the Health IT Module processed
          Must Support elements that asserted missing information.

          [Click here](#{resume_pass_url}?token=#{identifier}) if the tester visually confirmed system **meets** this requirement.

          [Click here](#{resume_fail_url}?token=#{identifier}) if the tester visually confirmed system **does not meet** this requirement.
        MESSAGE
      )
    end
  end
end
