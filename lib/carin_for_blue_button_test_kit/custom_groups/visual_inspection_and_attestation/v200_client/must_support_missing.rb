module CarinForBlueButtonTestKit
  class CARIN4BBMustSupportMissingTest < Inferno::Test
    title 'Interprets missing Must Support data elements'
    description <<~DESCRIPTION
      The Health IT Module must interpret missing Must Support data elements within resource instances as
      data not present in the Health Plan API actors system.
    DESCRIPTION
    id :c4bb_must_support_missing

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@6'

    input :c4bb_must_support_missing_options,
          title: 'Interprets missing Must Support data elements',
          description: %(
            The developer of the Health IT Module attests that the Health IT Module interpreted missing Must Support
              data elements within resource instances as data not present in the Health Plan API actors system.
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
    input :c4bb_must_support_missing_note,
          title: 'Notes, if applicable:',
          type: 'textarea',
          optional: true

    run do
      assert c4bb_must_support_missing_options == 'true', %(
        The following was not satisfied:

          The Health IT Module must interpret missing Must Support data elements within resource instances as
          data not present in the Health Plan API actors system.

      )
      pass c4bb_must_support_missing_note if c4bb_must_support_missing_note.present?
    end

  end
end