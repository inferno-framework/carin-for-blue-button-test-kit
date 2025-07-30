module CarinForBlueButtonTestKit
  class CARIN4BBLastUpdatedTest < Inferno::Test
    title 'Uses meta.lastUpdated value appropriately'
    description <<~DESCRIPTION
      The Health IT Module must use the meta.lastUpdated value to determine if the associated data is
      accurate as of the date of service or as of the current date.
    DESCRIPTION
    id :c4bb_last_updated

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@90',
                          'hl7.fhir.us.carin-bb_2.0.0@94',
                          'hl7.fhir.us.carin-bb_2.0.0@180',
                          'hl7.fhir.us.carin-bb_2.0.0@184',
                          'hl7.fhir.us.carin-bb_2.0.0@188'

    input :c4bb_last_updated_options,
          title: 'Uses meta.lastUpdated value appropriately',
          description: %(
            The developer of the Health IT Module attests that the Health IT Module used the
              meta.lastUpdated value to determine if the associated data is accurate as of the date of service or as of the current date.
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
    input :c4bb_last_updated_note,
          title: 'Notes, if applicable:',
          type: 'textarea',
          optional: true

    run do
      assert c4bb_last_updated_options == 'true', %(
        The following was not satisfied:

          The Health IT Module must use the meta.lastUpdated value to determine if the associated data is
          accurate as of the date of service or as of the current date.

      )
      pass c4bb_last_updated_note if c4bb_last_updated_note.present?
    end

  end
end