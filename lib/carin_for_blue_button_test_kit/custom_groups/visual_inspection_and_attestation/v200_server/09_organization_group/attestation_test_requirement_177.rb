module CarinForBlueButtonTestKit
  class AttestationTestCarinV2Requirement177 < Inferno::Test
    title 'Properly populates the NPI identifier'
    description <<~DESCRIPTION
      The Health IT Module populates the Service Facility `identifier[NPI]` in the
      Organization resource when assigned, and uses the value 'NPI has not been assigned' when no
      NPI has been assigned to the Service Location Organization.
    DESCRIPTION
    id :carin_server_requirement_177_attestation

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@177'

    input :carin_server_requirement_177_attestation_options,
          title: 'Properly populates the NPI identifier',
          description: %(
            I attest that the Health IT Module populates the Service Facility `identifier[NPI]` in the
              Organization resource when assigned, and uses the value 'NPI has not been assigned' when no
              NPI has been assigned to the Service Location Organization.
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
    input :carin_server_requirement_177_attestation_note,
          title: 'Notes, if applicable:',
          type: 'textarea',
          optional: true


        run do
          assert carin_server_requirement_177_attestation_options == 'true', %(
            The following was not satisfied:

            The Health IT Module populates the Service Facility `identifier[NPI]` in the
            Organization resource when assigned, and uses the value 'NPI has not been assigned' when no
            NPI has been assigned to the Service Location Organization.

          )
          pass carin_server_requirement_177_attestation_note if carin_server_requirement_177_attestation_note.present?
        end

  end
end
