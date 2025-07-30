module CarinForBlueButtonTestKit
  class AttestationTestCarinV2Requirement99 < Inferno::Test
    title 'Lists CARIN-BB profiles in the meta.profile of each resource'
    description <<~DESCRIPTION
      The Health IT Module includes the appropriate CARIN-BB profile URL(s) in the `meta.profile` field
      of each FHIR resource instance it returns.
    DESCRIPTION
    id :carin_server_requirement_99_attestation

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@99'

    input :carin_server_requirement_99_attestation_options,
          title: 'Lists CARIN-BB profiles in the meta.profile of each resource',
          description: %(
            I attest that each FHIR resource returned by the Health IT Module includes the appropriate
              CARIN-BB profile URL(s) in the `meta.profile` element.
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
    input :carin_server_requirement_99_attestation_note,
          title: 'Notes, if applicable:',
          type: 'textarea',
          optional: true


        run do
          assert carin_server_requirement_99_attestation_options == 'true', %(
            The following was not satisfied:

            The Health IT Module includes the appropriate CARIN-BB profile URL(s) in the `meta.profile` field
            of each FHIR resource instance it returns.

          )
          pass carin_server_requirement_99_attestation_note if carin_server_requirement_99_attestation_note.present?
        end

  end
end
