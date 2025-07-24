module CarinForBlueButtonTestKit
  class CarinLicensingTest < Inferno::Test
    title 'Complies with licensing requirements'

    description <<~DESCRIPTION
      The Health IT Module abides by the license
      requirements for each terminology content artifact utilized within a functioning implementation and obtained
      terminology licenses from the Third-Party IP owner for each code system and/or other specified artifact used.
    DESCRIPTION

    id :carin_licensing_test

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@30',
                          'hl7.fhir.us.carin-bb_2.0.0@31'

    input :carin_licensing_test_options,
          title: 'Complies with licensing requirements',
          description: %(
            The developer of the Health IT Module attests that the Health IT Module abides by the license
              requirements for each terminology content artifact utilized within a functioning implementation and obtained
              terminology licenses from the Third-Party IP owner for each code system and/or other specified artifact used.
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
    input :carin_licensing_test_note,
          title: 'Notes, if applicable:',
          type: 'textarea',
          optional: true



    run do
      assert carin_licensing_test_options == 'true',
             'Client application did not demonstrate correct usage of the authorization code.'
      pass carin_licensing_test_note if carin_licensing_test_note.present?
    end

  end
end
