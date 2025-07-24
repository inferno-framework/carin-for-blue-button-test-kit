module CarinForBlueButtonTestKit
  class AttestationTestCarinV2Requirement9 < Inferno::Test
    title 'Omits Must Support elements with cardinality >= 0 if data is not present'
    description <<~DESCRIPTION
      The Health IT Module omits `Must Support` data elements from the resource if the element's minimum
      cardinality is 0 and no data is available from the source system.
    DESCRIPTION
    id :carin_server_requirement_9_attestation

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@9'

    input :carin_server_requirement_9_attestation_options,
          title: 'Omits Must Support elements with cardinality >= 0 if data is not present',
          description: %(
            I attest that the Health IT Module omits `Must Support` elements with minimum cardinality = 0
              when the source system has no data available for them.
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
    input :carin_server_requirement_9_attestation_note,
          title: 'Notes, if applicable:',
          type: 'textarea',
          optional: true



    run do
      assert carin_server_requirement_9_attestation_options == 'true',
             'Client application did not demonstrate correct usage of the authorization code.'
      pass carin_server_requirement_9_attestation_note if carin_server_requirement_9_attestation_note.present?
    end

  end
end
