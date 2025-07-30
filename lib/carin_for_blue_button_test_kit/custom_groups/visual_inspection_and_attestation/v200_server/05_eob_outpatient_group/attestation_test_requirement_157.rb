module CarinForBlueButtonTestKit
  class AttestationTestCarinV2Requirement157_158_159 < Inferno::Test
    title 'Correctly populates EOB.item.productOrService'
    description <<~DESCRIPTION
      The Health IT Module:
      - Defines CPT, HCPCS, or HIPPS codes in `item.productOrService` as CodeableConcepts,
      - Ensures `item.productOrService` is populated whenever `.item` is present,
      - Enforces a cardinality of 1..1 for `item.productOrService`.
    DESCRIPTION
    id :carin_server_requirement_157_158_159_attestation

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@157',
                          'hl7.fhir.us.carin-bb_2.0.0@158',
                          'hl7.fhir.us.carin-bb_2.0.0@159'

    input :carin_server_requirement_157_158_159_attestation_options,
          title: 'Correctly populates EOB.item.productOrService',
          description: %(
            I attest that the Health IT Module:

              - Defines CPT, HCPCS, or HIPPS codes in `item.productOrService` and represents them as CodeableConcepts,
              - Populates `item.productOrService` whenever `EOB.item` is present,
              - Enforces that `item.productOrService` has a cardinality of 1..1.
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
    input :carin_server_requirement_157_158_159_attestation_note,
          title: 'Notes, if applicable:',
          type: 'textarea',
          optional: true


        run do
          assert carin_server_requirement_157_158_159_attestation_options == 'true', %(
            The following was not satisfied:

            The Health IT Module:
            - Defines CPT, HCPCS, or HIPPS codes in `item.productOrService` as CodeableConcepts,
            - Ensures `item.productOrService` is populated whenever `.item` is present,
            - Enforces a cardinality of 1..1 for `item.productOrService`.

          )
          pass carin_server_requirement_157_158_159_attestation_note if carin_server_requirement_157_158_159_attestation_note.present?
        end

  end
end
