# frozen_string_literal: true

module CarinForBlueButtonTestKit
  class CarinLicensingTest < Inferno::Test
    title 'Complies with licensing requirements'

    description <<~DESCRIPTION
      The Health IT Module abides by the license
      requirements for each terminology content artifact utilized within a functioning implementation and obtained
      terminology licenses from the Third-Party IP owner for each code system and/or other specified artifact used.
    DESCRIPTION

    id :carin_licensing_test

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@30',
                          'hl7.fhir.us.carin-bb_2.0.0@31'

    run do
      identifier = SecureRandom.hex(32)

      wait(
        identifier:,
        message: <<~MESSAGE
          The developer of the Health IT Module attests that the Health IT Module abides by the license
          requirements for each terminology content artifact utilized within a functioning implementation and obtained
          terminology licenses from the Third-Party IP owner for each code system and/or other specified artifact used.

          [Click here](#{resume_pass_url}?token=#{identifier}) if the system **meets** these requirements.

          [Click here](#{resume_fail_url}?token=#{identifier}) if the system **does not meet** these requirements.
        MESSAGE
      )
    end
  end
end
