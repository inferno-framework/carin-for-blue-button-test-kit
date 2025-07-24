module CarinForBlueButtonTestKit
  class AttestationTestCarinV2Requirement105 < Inferno::Test
    title 'Uses versioned references when point-in-time data is maintained'
    description <<~DESCRIPTION
      The Health IT Module uses versioned references when an ExplanationOfBenefit
      references another resource whenever point-in-time data is maintained, reflecting the data
      effective as of the date of service or admission on the claim.
    DESCRIPTION
    id :carin_server_requirement_105_attestation

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@105'

    input :carin_server_requirement_105_attestation_options,
          title: 'Uses versioned references when point-in-time data is maintained',
          description: %(
            I attest that the Health IT Module uses versioned references when an ExplanationOfBenefit
              references another resource whenever point-in-time data is maintained, reflecting the data
              effective as of the date of service or admission on the claim.
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
    input :carin_server_requirement_105_attestation_note,
          title: 'Notes, if applicable:',
          type: 'textarea',
          optional: true



    run do
      assert carin_server_requirement_105_attestation_options == 'true',
             'Client application did not demonstrate correct usage of the authorization code.'
      pass carin_server_requirement_105_attestation_note if carin_server_requirement_105_attestation_note.present?
    end

  end
end
