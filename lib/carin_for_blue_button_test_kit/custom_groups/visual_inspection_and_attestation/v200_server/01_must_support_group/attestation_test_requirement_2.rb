module CarinForBlueButtonTestKit
  class AttestationTestCarinV2Requirement2 < Inferno::Test
    title 'Returns maintained data'
    description <<~DESCRIPTION
      The Health IT Module is capable of populating and returning all data elements maintained
      by the payer as part of the query results, as specified by the CARIN Blue Button Health Plan API
      CapabilityStatement.
    DESCRIPTION
    id :carin_server_requirement_2_attestation

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@2'

    input :carin_server_requirement_2_attestation_options,
          title: 'Returns maintained data',
          description: %(
            I attest that the Health IT Module is capable of populating and returning all data elements maintained
              by the payer as part of the query results, as specified by the CARIN Blue Button Health Plan API
              CapabilityStatement.
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
    input :carin_server_requirement_2_attestation_note,
          title: 'Notes, if applicable:',
          type: 'textarea',
          optional: true


        run do
          assert carin_server_requirement_2_attestation_options == 'true', %(
            The following was not satisfied:

            The Health IT Module is capable of populating and returning all data elements maintained
            by the payer as part of the query results, as specified by the CARIN Blue Button Health Plan API
            CapabilityStatement.

          )
          pass carin_server_requirement_2_attestation_note if carin_server_requirement_2_attestation_note.present?
        end

  end
end
