module CarinForBlueButtonTestKit
  class AttestationTestCarinV2Requirement150 < Inferno::Test
    title 'Uses procedure codes not revenue codes'
    description <<~DESCRIPTION
      The `item.productOrService` element in an oral ExplanationOfBenefit resource
      is populated with CPT or HCPCS procedure codes as CodeableConcept values, and that revenue
      codes are not used for oral claims.
    DESCRIPTION
    id :carin_server_requirement_150_attestation

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@150'

    input :carin_server_requirement_150_attestation_options,
          title: 'Uses procedure codes not revenue codes',
          description: %(
            I attest that the `item.productOrService` element in an oral ExplanationOfBenefit resource
              is populated with CPT or HCPCS procedure codes as CodeableConcept values, and that revenue
              codes are not used for oral claims.
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
    input :carin_server_requirement_150_attestation_note,
          title: 'Notes, if applicable:',
          type: 'textarea',
          optional: true

    run do
      assert carin_server_requirement_150_attestation_options == 'true', %(
        The following was not satisfied:

          The `item.productOrService` element in an oral ExplanationOfBenefit resource
          is populated with CPT or HCPCS procedure codes as CodeableConcept values, and that revenue
          codes are not used for oral claims.

      )
      pass carin_server_requirement_150_attestation_note if carin_server_requirement_150_attestation_note.present?
    end

  end
end
