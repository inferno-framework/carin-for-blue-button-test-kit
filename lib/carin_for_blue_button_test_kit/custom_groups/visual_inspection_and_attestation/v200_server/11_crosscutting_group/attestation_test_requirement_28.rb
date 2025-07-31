module CarinForBlueButtonTestKit
  class AttestationTestCarinV2Requirement28 < Inferno::Test
    title 'Ensures conformant CPCDS data'
    description <<~DESCRIPTION
      The Health IT Module ensures that data representing the Common Payer Consumer Data Set (CPCDS)
      conforms to the specified profiles, vocabulary standards, and code sets required by the specification.
    DESCRIPTION
    id :carin_server_requirement_28_attestation

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@28'

    input :carin_server_requirement_28_attestation_options,
          title: 'Ensures conformant CPCDS data',
          description: %(
            I attest that the Health IT Module ensures CPCDS data conforms to the specified profiles,
              vocabulary standards, and code sets outlined in the specification.
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
    input :carin_server_requirement_28_attestation_note,
          title: 'Notes, if applicable:',
          type: 'textarea',
          optional: true

    run do
      assert carin_server_requirement_28_attestation_options == 'true', %(
        The following was not satisfied:

          The Health IT Module ensures that data representing the Common Payer Consumer Data Set (CPCDS)
          conforms to the specified profiles, vocabulary standards, and code sets required by the specification.

      )
      pass carin_server_requirement_28_attestation_note if carin_server_requirement_28_attestation_note.present?
    end

  end
end
