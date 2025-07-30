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

    input :c4bb_authentication_options,
          title: 'Uses appropriate authentication',
          description: %(
            I attest that the Health IT Module
              - Directed communication through authenticated, authorized, and secure channels.
              - Used the SMART App Launch Framework’s standalone launch.
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
    input :c4bb_authentication_note,
          title: 'Notes, if applicable:',
          type: 'textarea',
          optional: true


        run do
          assert c4bb_authentication_options == 'true', %(
            The following was not satisfied:

            The Health IT Module must
            - Direct communication through authenticated, authorized, and secure channels.
            - Use the SMART App Launch Framework’s standalone launch.

          )
          pass c4bb_authentication_note if c4bb_authentication_note.present?
        end

  end
end
