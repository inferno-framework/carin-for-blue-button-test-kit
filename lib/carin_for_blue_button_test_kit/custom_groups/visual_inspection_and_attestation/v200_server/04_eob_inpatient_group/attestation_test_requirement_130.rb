module CarinForBlueButtonTestKit
  class AttestationTestCarinV2Requirement130 < Inferno::Test
    title 'Provides claim amounts if line item amounts unavailable'
    description <<~DESCRIPTION
      If line item amounts are not available, the Health IT Module provides the claim amounts
      and corresponding amount types in the ExplanationOfBenefit (EOB) header data elements, as specified
      by the CPCDS data elements.
    DESCRIPTION
    id :carin_server_requirement_130_attestation

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@130'

    input :carin_server_requirement_130_attestation_options,
          title: 'Provides claim amounts if line item amounts unavailable',
          description: %(
            I attest that if line item amounts are not available, the Health IT Module provides the claim amounts
              and corresponding amount types in the ExplanationOfBenefit (EOB) header data elements, as specified
              by the CPCDS data elements.
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
    input :carin_server_requirement_130_attestation_note,
          title: 'Notes, if applicable:',
          type: 'textarea',
          optional: true



    run do
      assert carin_server_requirement_130_attestation_options == 'true',
             'Client application did not demonstrate correct usage of the authorization code.'
      pass carin_server_requirement_130_attestation_note if carin_server_requirement_130_attestation_note.present?
    end

  end
end
