module CarinForBlueButtonTestKit
  class AttestationTestCarinV2Requirement5 < Inferno::Test
    title 'Does not include absent data with unknown reason'
    description <<~DESCRIPTION
      In situations where information for a particular data element is not present and
      the reason for its absence is unknown, the Health IT Module does not include the data element in
      the resource instance returned as part of the query results.
    DESCRIPTION
    id :carin_server_requirement_5_attestation

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@5'

    input :carin_server_requirement_5_attestation_options,
          title: 'Does not include absent data with unknown reason',
          description: %(
            I attest that in situations where information for a particular data element is not present and
              the reason for its absence is unknown, the Health IT Module does not include the data element in
              the resource instance returned as part of the query results.
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
    input :carin_server_requirement_5_attestation_note,
          title: 'Notes, if applicable:',
          type: 'textarea',
          optional: true



    run do
      assert carin_server_requirement_5_attestation_options == 'true',
             'Client application did not demonstrate correct usage of the authorization code.'
      pass carin_server_requirement_5_attestation_note if carin_server_requirement_5_attestation_note.present?
    end

  end
end
