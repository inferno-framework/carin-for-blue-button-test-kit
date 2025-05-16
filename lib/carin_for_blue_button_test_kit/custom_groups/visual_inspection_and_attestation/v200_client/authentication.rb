module CarinForBlueButtonTestKit
  class CARIN4BBAuthTest < Inferno::Test
    title 'Uses appropriate authentication'
    description <<~DESCRIPTION
      The Health IT Module must
      - Direct communication through authenticated, authorized, and secure channels.
      - Use the SMART App Launch Framework’s standalone launch.
    DESCRIPTION
    id :c4bb_authentication

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@1',
                          'hl7.fhir.us.carin-bb_2.0.0@48'

    run do
      identifier = SecureRandom.hex(32)
      wait(
        identifier:,
        message: <<~MESSAGE
          I attest that the Health IT Module
          - Directed communication through authenticated, authorized, and secure channels.
          - Used the SMART App Launch Framework’s standalone launch.

          [Click here](#{resume_pass_url}?token=#{identifier}) if the tester visually confirmed system **meets** this requirement.

          [Click here](#{resume_fail_url}?token=#{identifier}) if the tester visually confirmed system **does not meet** this requirement.
        MESSAGE
      )
    end
  end
end
