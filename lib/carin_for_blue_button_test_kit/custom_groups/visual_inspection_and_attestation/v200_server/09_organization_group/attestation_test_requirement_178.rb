module CarinForBlueButtonTestKit
  class AttestationTestCarinV2Requirement178 < Inferno::Test
    title 'Does not populate "address" when part of Billing Provider'
    description <<~DESCRIPTION
      The Health IT Module does not populate the Organization resource `address` element
      when the location where services were rendered is a component of the Billing Provider.
    DESCRIPTION
    id :carin_server_requirement_178_attestation

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@178'

    input :carin_server_requirement_178_attestation_options,
          title: 'Does not populate "address" when part of Billing Provider',
          description: %(
            I attest that the Health IT Module does not populate the Organization resource `address` element
              when the location where services were rendered is a component of the Billing Provider.
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
    input :carin_server_requirement_178_attestation_note,
          title: 'Notes, if applicable:',
          type: 'textarea',
          optional: true

    run do
      assert carin_server_requirement_178_attestation_options == 'true', %(
        The following was not satisfied:

          The Health IT Module does not populate the Organization resource `address` element
          when the location where services were rendered is a component of the Billing Provider.

      )
      pass carin_server_requirement_178_attestation_note if carin_server_requirement_178_attestation_note.present?
    end

  end
end
