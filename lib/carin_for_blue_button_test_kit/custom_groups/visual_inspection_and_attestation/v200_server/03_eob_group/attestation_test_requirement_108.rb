module CarinForBlueButtonTestKit
  class AttestationTestCarinV2Requirement108 < Inferno::Test
    title 'Supports versioned and unversioned references'
    description <<~DESCRIPTION
      The Health IT Module supports both versioned and non-versioned ExplanationOfBenefit
      reference approaches when referencing another resource,
      and returns the same content for referenced resources in either case.
    DESCRIPTION
    id :carin_server_requirement_108_attestation

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@108'

    input :carin_server_requirement_108_attestation_options,
          title: 'Supports versioned and unversioned references',
          description: %(
            I attest that the Health IT Module supports both versioned and non-versioned ExplanationOfBenefit
              reference approaches when referencing another resource,
              and returns the same content for referenced resources in either case.
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
    input :carin_server_requirement_108_attestation_note,
          title: 'Notes, if applicable:',
          type: 'textarea',
          optional: true

    run do
      assert carin_server_requirement_108_attestation_options == 'true', %(
        The following was not satisfied:

          The Health IT Module supports both versioned and non-versioned ExplanationOfBenefit
          reference approaches when referencing another resource,
          and returns the same content for referenced resources in either case.

      )
      pass carin_server_requirement_108_attestation_note if carin_server_requirement_108_attestation_note.present?
    end

  end
end
