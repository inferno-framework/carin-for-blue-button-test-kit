module CarinForBlueButtonTestKit
  class CARIN4BBMustSupportProcessTest < Inferno::Test
    title 'Processes Must Support data elements'
    description <<~DESCRIPTION
      The Health IT Module behaving as a client must process all Must Support data elements without error.
    DESCRIPTION
    id :c4bb_must_support_process

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@3'

    run do
      identifier = SecureRandom.hex(32)
      wait(
        identifier:,
        message: <<~MESSAGE
          I attest that the Health IT Module behaving as a client successfully processed all resource instances containing
          Must Support data elements without generating an error or causing the application to fail.

          [Click here](#{resume_pass_url}?token=#{identifier}) if the tester visually confirmed system **meets** this requirement.

          [Click here](#{resume_fail_url}?token=#{identifier}) if the tester visually confirmed system **does not meet** this requirement.
        MESSAGE
      )
    end
  end
end
