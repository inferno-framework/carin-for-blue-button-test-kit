module CarinForBlueButtonTestKit
  class AttestationTestCarinV2Requirement149 < Inferno::Test
    title 'References sequence number of associated diagnosis'
    description <<~DESCRIPTION
      The `item.diagnosisSequence` element references the sequence number of the associated
      diagnosis listed in the ExplanationOfBenefit resource.
    DESCRIPTION
    id :carin_server_requirement_149_attestation

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@149'

    input :carin_server_requirement_149_attestation_options,
          title: 'References sequence number of associated diagnosis',
          description: %(
            I attest that the `item.diagnosisSequence` element references the sequence number of the associated
              diagnosis listed in the ExplanationOfBenefit resource.
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
    input :carin_server_requirement_149_attestation_note,
          title: 'Notes, if applicable:',
          type: 'textarea',
          optional: true



    run do
      assert carin_server_requirement_149_attestation_options == 'true',
             'Client application did not demonstrate correct usage of the authorization code.'
      pass carin_server_requirement_149_attestation_note if carin_server_requirement_149_attestation_note.present?
    end

  end
end
