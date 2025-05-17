module CarinForBlueButtonTestKit
  class MetaLastUpdatedTest < Inferno::Test
    title 'Properly populates ".lastUpdated"'

    description <<~DESCRIPTION
      For
        - C4BB-Organization
        - C4BB-Patient
        - C4BB-Practitioner
        - All reference resources within a C4BB-ExplanationOfBenefit

      The Health IT Module uses `.meta.lastUpdated` to mean the last time the data was updated or the date of creation in the
      payer's system of record, whichever comes last.
    DESCRIPTION

    id :meta_last_updated

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@89',
                          'hl7.fhir.us.carin-bb_2.0.0@93',
                          'hl7.fhir.us.carin-bb_2.0.0@179',
                          'hl7.fhir.us.carin-bb_2.0.0@183',
                          'hl7.fhir.us.carin-bb_2.0.0@187'

    run do
      identifier = SecureRandom.hex(32)

      wait(
        identifier:,
        message: <<~MESSAGE
          For
            - C4BB-Organization
            - C4BB-Patient
            - C4BB-Practitioner

          The developer of the Health IT Module attests that#{' '}
          `.meta.lastUpdated` means the last time the data was updated or the date of creation in the payer's
          system of record, whichever comes last.

          [Click here](#{resume_pass_url}?token=#{identifier}) if the system **meets** these requirements.

          [Click here](#{resume_fail_url}?token=#{identifier}) if the system **does not meet** these requirements.
        MESSAGE
      )
    end
  end
end
