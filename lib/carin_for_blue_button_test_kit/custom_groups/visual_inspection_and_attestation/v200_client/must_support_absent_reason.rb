module CarinForBlueButtonTestKit
  class CARIN4BBMustSupportAbsentReasonTest < Inferno::Test
    title 'Processes Must Support elements that assert missing information'
    description <<~DESCRIPTION
      The Health IT Module must process Must Support elements that assert missing information.
    DESCRIPTION
    id :c4bb_must_support_absent_reason

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@8'

    input :c4bb_must_support_absent_reason_options,
          title: 'Processes Must Support elements that assert missing information',
          description: %(
            The developer of the Health IT Module attests that the Health IT Module processed
              Must Support elements that asserted missing information.
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
    input :c4bb_must_support_absent_reason_note,
          title: 'Notes, if applicable:',
          type: 'textarea',
          optional: true



    run do
      assert c4bb_must_support_absent_reason_options == 'true',
             'Client application did not demonstrate correct usage of the authorization code.'
      pass c4bb_must_support_absent_reason_note if c4bb_must_support_absent_reason_note.present?
    end

  end
end
