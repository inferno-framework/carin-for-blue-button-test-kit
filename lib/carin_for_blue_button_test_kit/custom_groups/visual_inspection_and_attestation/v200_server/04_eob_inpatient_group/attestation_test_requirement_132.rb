module CarinForBlueButtonTestKit
  class AttestationTestCarinV2Requirement132 < Inferno::Test
    title 'Includes in-network or out-of-network payment status'
    description <<~DESCRIPTION
      The Health IT Module includes the in-network or out-of-network payment status of the
      claim within the `EOB.supportingInfo` element, as specified by the CPCDS data elements.
    DESCRIPTION
    id :carin_server_requirement_132_attestation

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@132'

    input :carin_server_requirement_132_attestation_options,
          title: 'Includes in-network or out-of-network payment status',
          description: %(
            I attest that the Health IT Module includes the in-network or out-of-network payment status of the
              claim within the `EOB.supportingInfo` element, as specified by the CPCDS data elements.
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
    input :carin_server_requirement_132_attestation_note,
          title: 'Notes, if applicable:',
          type: 'textarea',
          optional: true


        run do
          assert carin_server_requirement_132_attestation_options == 'true', %(
            The following was not satisfied:

            The Health IT Module includes the in-network or out-of-network payment status of the
            claim within the `EOB.supportingInfo` element, as specified by the CPCDS data elements.

          )
          pass carin_server_requirement_132_attestation_note if carin_server_requirement_132_attestation_note.present?
        end

  end
end
