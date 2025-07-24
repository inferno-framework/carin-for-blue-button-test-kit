module CarinForBlueButtonTestKit
  class AttestationTestCarinV2Requirement186 < Inferno::Test
    title 'Populates an identifier'
    description <<~DESCRIPTION
      The Health IT Module populates the Practitioner resource with at least one identifier,
      either an NPI or a Tax ID.
    DESCRIPTION
    id :carin_server_requirement_186_attestation

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@186'

    input :carin_server_requirement_186_attestation_options,
          title: 'Populates an identifier',
          description: %(
            I attest that the Health IT Module populates the Practitioner resource with at least one identifier,
              either an NPI or a Tax ID.
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
    input :carin_server_requirement_186_attestation_note,
          title: 'Notes, if applicable:',
          type: 'textarea',
          optional: true



    run do
      assert carin_server_requirement_186_attestation_options == 'true',
             'Client application did not demonstrate correct usage of the authorization code.'
      pass carin_server_requirement_186_attestation_note if carin_server_requirement_186_attestation_note.present?
    end

  end
end
