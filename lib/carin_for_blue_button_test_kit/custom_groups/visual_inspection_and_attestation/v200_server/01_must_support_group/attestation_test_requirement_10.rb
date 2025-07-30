module CarinForBlueButtonTestKit
  class AttestationTestCarinV2Requirement10 < Inferno::Test
    title 'Follows FHIR and US Core guidance when data is unavailable'
    description <<~DESCRIPTION
      The Health IT Module follows the FHIR core specification and US Core guidance when no data is available
      for required data elements (minimum cardinality > 0).
    DESCRIPTION
    id :carin_server_requirement_10_attestation

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@10'

    input :carin_server_requirement_10_attestation_options,
          title: 'Follows FHIR and US Core guidance when data is unavailable',
          description: %(
            I attest that the Health IT Module applies FHIR and US Core guidance
              when the source system lacks data for required elements with minimum cardinality > 0.
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
    input :carin_server_requirement_10_attestation_note,
          title: 'Notes, if applicable:',
          type: 'textarea',
          optional: true


        run do
          assert carin_server_requirement_10_attestation_options == 'true', %(
            The following was not satisfied:

            The Health IT Module follows the FHIR core specification and US Core guidance when no data is available
            for required data elements (minimum cardinality > 0).

          )
          pass carin_server_requirement_10_attestation_note if carin_server_requirement_10_attestation_note.present?
        end

  end
end
