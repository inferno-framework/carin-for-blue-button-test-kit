module CarinForBlueButtonTestKit
  class AttestationTestCarinV2Requirement162 < Inferno::Test
    title 'Populates with "compound" and maps correctly'
    description <<~DESCRIPTION
      When the Compound Code is 2, the `item.productOrService` element is populated with the value
      "compound" and that the ingredient information is mapped to `item.detail.productOrService.`
    DESCRIPTION
    id :carin_server_requirement_162_attestation

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@162'

    input :carin_server_requirement_162_attestation_options,
          title: 'Populates with ',
          description: %(
            I attest that when the Compound Code is 2, the `item.productOrService` element is populated with the value
              "compound" and that the ingredient information is mapped to `item.detail.productOrService.`
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
    input :carin_server_requirement_162_attestation_note,
          title: 'Notes, if applicable:',
          type: 'textarea',
          optional: true


        run do
          assert carin_server_requirement_162_attestation_options == 'true', %(
            The following was not satisfied:

            When the Compound Code is 2, the `item.productOrService` element is populated with the value
            "compound" and that the ingredient information is mapped to `item.detail.productOrService.`

          )
          pass carin_server_requirement_162_attestation_note if carin_server_requirement_162_attestation_note.present?
        end

  end
end
