module CarinForBlueButtonTestKit
  class CARIN4BBMustSupportDisplayTest < Inferno::Test
    title 'Can display Must Support data elements'
    description <<~DESCRIPTION
      The Health IT Module must be capable of displaying all Must Support data elements.
    DESCRIPTION
    id :c4bb_must_support_display

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@4'

    input :c4bb_must_support_display_options,
          title: 'Can display Must Support data elements',
          description: %(
            The developer of the Health IT Module attests that the Health IT Module can display all
              Must Support data elements for human use.
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
    input :c4bb_must_support_display_note,
          title: 'Notes, if applicable:',
          type: 'textarea',
          optional: true

    run do
      assert c4bb_must_support_display_options == 'true', %(
        The following was not satisfied:

          The Health IT Module must be capable of displaying all Must Support data elements.

      )
      pass c4bb_must_support_display_note if c4bb_must_support_display_note.present?
    end

  end
end