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

    input :meta_last_updated_options,
          title: 'Properly populates ',
          description: %(
            For
                - C4BB-Organization
                - C4BB-Patient
                - C4BB-Practitioner

              The developer of the Health IT Module attests that#{' '}
              `.meta.lastUpdated` means the last time the data was updated or the date of creation in the payer's
              system of record, whichever comes last.
          ),
          type: 'radio',
          default: 'false',
          options: {
            list_options: [
              {
                label: 'Yes',
                value: 'true'
              },
              {
                label: 'No',
                value: 'false'
              }
            ]
          }
    input :meta_last_updated_note,
          title: 'Notes, if applicable:',
          type: 'textarea',
          optional: true



    run do
      assert meta_last_updated_options == 'true',
             'Client application did not demonstrate correct usage of the authorization code.'
      pass meta_last_updated_note if meta_last_updated_note.present?
    end

  end
end
