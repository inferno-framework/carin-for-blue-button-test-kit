module CarinForBlueButtonTestKit
  class AttestationTestCarinV2Requirement7 < Inferno::Test
    title 'Includes reason for missing Must Support elements'
    description <<~DESCRIPTION
      When a Must Support element is missing and the reason for the absence is known,
      the Health IT Module includes a reason using either:
      - a value such as a nullFlavor from the relevant value set, or  
      - the `dataAbsentReason` extension.
    DESCRIPTION
    id :carin_server_requirement_7_attestation

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@7'

    input :carin_server_requirement_7_attestation_options,
          title: 'Includes reason for missing Must Support elements',
          description: %(
            The developer of the Health IT Module attests that when a Must Support element is missing and the
              reason for the absence is known, the Health IT Module includes a reason using either:
              - a value such as a nullFlavor from the relevant value set, or  
              - the `dataAbsentReason` extension.
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
    input :carin_server_requirement_7_attestation_note,
          title: 'Notes, if applicable:',
          type: 'textarea',
          optional: true



    run do
      assert carin_server_requirement_7_attestation_options == 'true',
             'Client application did not demonstrate correct usage of the authorization code.'
      pass carin_server_requirement_7_attestation_note if carin_server_requirement_7_attestation_note.present?
    end

  end
end
