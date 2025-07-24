module CarinForBlueButtonTestKit
  class AttestationTestCarinV2Requirement163 < Inferno::Test
    title 'Populates with NDC code'
    description <<~DESCRIPTION
      Both `item.productOrService` and `item.detail.productOrService` elements are populated with
      an 11-digit NDC code.
    DESCRIPTION
    id :carin_server_requirement_163_attestation

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@163'

    input :carin_server_requirement_163_attestation_options,
          title: 'Populates with NDC code',
          description: %(
            I attest that both `item.productOrService` and `item.detail.productOrService` elements are populated with
              an 11-digit NDC code.
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
    input :carin_server_requirement_163_attestation_note,
          title: 'Notes, if applicable:',
          type: 'textarea',
          optional: true



    run do
      assert carin_server_requirement_163_attestation_options == 'true',
             'Client application did not demonstrate correct usage of the authorization code.'
      pass carin_server_requirement_163_attestation_note if carin_server_requirement_163_attestation_note.present?
    end

  end
end
