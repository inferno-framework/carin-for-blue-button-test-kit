module CarinForBlueButtonTestKit
  class AdjudicationAmountTest < Inferno::Test
    title 'Properly uses ".adjudication.amount"'

    description <<~DESCRIPTION
      For:
      -  C4BB ExplanationOfBenefit Inpatient Institutional `.adjudication.amount`
      -  C4BB ExplanationOfBenefit Outpatient Institutional `.adjudication.amount`

      The Health IT Module must only populate `.adjudication.amount` if `.item.adjudication` is not available.
    DESCRIPTION

    id :adjudication_amount

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@142',
                          'hl7.fhir.us.carin-bb_2.0.0@197'

    input :adjudication_amount_options,
          title: 'Properly uses ".adjudication.amount"',
          description: %(
            For:
            -  C4BB ExplanationOfBenefit Inpatient Institutional `.adjudication.amount`
            -  C4BB ExplanationOfBenefit Outpatient Institutional `.adjudication.amount`

            The developer of the Health IT Module attests that the Health IT Module only populates
            `.adjudication.amount` if `.item.adjudication` is not available.
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
    input :adjudication_amount_note,
          title: 'Notes, if applicable:',
          type: 'textarea',
          optional: true

    run do
      assert adjudication_amount_options == 'true', %(
        The following was not satisfied:

        For:
        -  C4BB ExplanationOfBenefit Inpatient Institutional `.adjudication.amount`
        -  C4BB ExplanationOfBenefit Outpatient Institutional `.adjudication.amount`

        The Health IT Module must only populate `.adjudication.amount` if `.item.adjudication` is not available.

      )
      pass adjudication_amount_note if adjudication_amount_note.present?
    end

  end
end
