module CarinForBlueButtonTestKit
  class AttestationTestCarinV2Requirement148 < Inferno::Test
    title 'Populates facility information when differs from billing'
    description <<~DESCRIPTION
      The Health Plan API populates `supportingInfo[service`facility`] with the name, full address,
      and identifier of the facility where services were rendered, when that facility differs from the Billing or
      Rendering Provider.
    DESCRIPTION
    id :carin_server_requirement_148_attestation

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@148'

    input :carin_server_requirement_148_attestation_options,
          title: 'Populates facility information when differs from billing',
          description: %(
            I attest that the Health Plan API populates `supportingInfo[service`facility`] with the name, full address,
              and identifier of the facility where services were rendered, when that facility differs from the Billing or
              Rendering Provider.
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
    input :carin_server_requirement_148_attestation_note,
          title: 'Notes, if applicable:',
          type: 'textarea',
          optional: true



    run do
      assert carin_server_requirement_148_attestation_options == 'true',
             'Client application did not demonstrate correct usage of the authorization code.'
      pass carin_server_requirement_148_attestation_note if carin_server_requirement_148_attestation_note.present?
    end

  end
end
