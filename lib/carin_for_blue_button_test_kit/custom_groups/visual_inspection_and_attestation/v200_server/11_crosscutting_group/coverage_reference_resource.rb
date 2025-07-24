module CarinForBlueButtonTestKit
  class CoverageReferenceResourceTest < Inferno::Test
    title 'Returns Coverage Reference Resource with correct data'

    description <<~DESCRIPTION
      The Health IT Module returns the Coverage Reference Resource with data that was effective as of the date of service of the claim.#{' '}
      For example, the data will reflect the employer name in effect at that time.
    DESCRIPTION

    id :coverage_reference_resource

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@87',
                          'hl7.fhir.us.carin-bb_2.0.0@91',
                          'hl7.fhir.us.carin-bb_2.0.0@175'

    input :coverage_reference_resource_options,
          title: 'Returns Coverage Reference Resource with correct data',
          description: %(
            I attest that the Health IT Module returns the Coverage Reference Resource with data that was effective as of the date of service of the claim.
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
    input :coverage_reference_resource_note,
          title: 'Notes, if applicable:',
          type: 'textarea',
          optional: true



    run do
      assert coverage_reference_resource_options == 'true',
             'Client application did not demonstrate correct usage of the authorization code.'
      pass coverage_reference_resource_note if coverage_reference_resource_note.present?
    end

  end
end
