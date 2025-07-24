require_relative '../urls'

module CarinForBlueButtonTestKit
  class ClientAttestationTest < Inferno::Test
    include URLs
    title 'CARIN Claims Data Client Attestation'
    description %(
      Attest that the all claims data was able to be received and processed by the client.
    )
    id :client_claims_data_attestation

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@3',
                          'hl7.fhir.us.carin-bb_2.0.0@13'

    input :client_claims_data_attestation_options,
          title: 'CARIN Claims Data Client Attestation',
          description: %(
            I attest that the client system under test was able to receive, process, and retain all of the requested
              CARIN for Blue Button claims data, including all of the profile data elements that have a minimum cardinality
              greater than or equal to 1 and/or flagged as Must Support as defined by that profiles StructureDefinition
              for each resource.
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
    input :client_claims_data_attestation_note,
          title: 'Notes, if applicable:',
          type: 'textarea',
          optional: true



    run do
      assert client_claims_data_attestation_options == 'true',
             'Client application did not demonstrate correct usage of the authorization code.'
      pass client_claims_data_attestation_note if client_claims_data_attestation_note.present?
    end

  end
end
