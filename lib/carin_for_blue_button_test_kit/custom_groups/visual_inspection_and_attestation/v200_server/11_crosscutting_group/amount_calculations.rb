module CarinForBlueButtonTestKit
  class AmountCalculationTest < Inferno::Test
    title 'Properly calculates "amount" fields'

    description <<~DESCRIPTION
      For:
        -  C4BB ExplanationOfBenefit Inpatient Institutional `.total.amount`
        -  C4BB ExplanationOfBenefit Inpatient Institutional `.item.adjudication.amount`
        -  C4BB ExplanationOfBenefit Inpatient Institutional `.adjudication.amount`
        -  C4BB ExplanationOfBenefit Outpatient Institutional `.total.amount`
        -  C4BB ExplanationOfBenefit Outpatient Institutional `.item.adjudication.amount`
        -  C4BB ExplanationOfBenefit Outpatient Institutional `.adjudication.amount`
        -  C4BB ExplanationOfBenefit Oral `.total.amount`
        -  C4BB ExplanationOfBenefit Oral `.item.adjudication.amount`
        -  C4BB ExplanationOfBenefit Professional NonClinician `.total.amount`
        -  C4BB ExplanationOfBenefit Professional NonClinician `.item.adjudication.amount`

      The Health IT Module calculates the total amount as follows:
           - Eligible amount = submitted amount - the noncovered amount - discount.

      The subscriber pays the member liability = deductible + coinsurance + copay + noncovered.

      (Part of the member liability may have already been paid to the provider as paidbypatient).

      The eligible amount - the member liability is the payment amount to the provider (paidtoprovider) or the subscriber (paidtopatient).
    DESCRIPTION

    id :amount_calculations

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@143',
                          'hl7.fhir.us.carin-bb_2.0.0@154',
                          'hl7.fhir.us.carin-bb_2.0.0@155',
                          'hl7.fhir.us.carin-bb_2.0.0@190',
                          'hl7.fhir.us.carin-bb_2.0.0@191',
                          'hl7.fhir.us.carin-bb_2.0.0@192',
                          'hl7.fhir.us.carin-bb_2.0.0@193',
                          'hl7.fhir.us.carin-bb_2.0.0@194',
                          'hl7.fhir.us.carin-bb_2.0.0@195',
                          'hl7.fhir.us.carin-bb_2.0.0@196'

    input :amount_calculations_options,
          title: 'Properly calculates ',
          description: %(
            For:
                -  C4BB ExplanationOfBenefit Inpatient Institutional `.total.amount`
                -  C4BB ExplanationOfBenefit Inpatient Institutional `.item.adjudication.amount`
                -  C4BB ExplanationOfBenefit Inpatient Institutional `.adjudication.amount`
                -  C4BB ExplanationOfBenefit Outpatient Institutional `.total.amount`
                -  C4BB ExplanationOfBenefit Outpatient Institutional `.item.adjudication.amount`
                -  C4BB ExplanationOfBenefit Outpatient Institutional `.adjudication.amount`
                -  C4BB ExplanationOfBenefit Oral `.total.amount`
                -  C4BB ExplanationOfBenefit Oral `.item.adjudication.amount`
                -  C4BB ExplanationOfBenefit Professional NonClinician `.total.amount`
                -  C4BB ExplanationOfBenefit Professional NonClinician `.item.adjudication.amount`

              The developer of the Health IT Module attests that the Health IT Module calculates the total amount as follows:
                  - Eligible amount = submitted amount - the noncovered amount - discount.
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
    input :amount_calculations_note,
          title: 'Notes, if applicable:',
          type: 'textarea',
          optional: true


        run do
          assert amount_calculations_options == 'true', %(
            The following was not satisfied:

            For:
              -  C4BB ExplanationOfBenefit Inpatient Institutional `.total.amount`
              -  C4BB ExplanationOfBenefit Inpatient Institutional `.item.adjudication.amount`
              -  C4BB ExplanationOfBenefit Inpatient Institutional `.adjudication.amount`
              -  C4BB ExplanationOfBenefit Outpatient Institutional `.total.amount`
              -  C4BB ExplanationOfBenefit Outpatient Institutional `.item.adjudication.amount`
              -  C4BB ExplanationOfBenefit Outpatient Institutional `.adjudication.amount`
              -  C4BB ExplanationOfBenefit Oral `.total.amount`
              -  C4BB ExplanationOfBenefit Oral `.item.adjudication.amount`
              -  C4BB ExplanationOfBenefit Professional NonClinician `.total.amount`
              -  C4BB ExplanationOfBenefit Professional NonClinician `.item.adjudication.amount`

            The Health IT Module calculates the total amount as follows:
                 - Eligible amount = submitted amount - the noncovered amount - discount.

            The subscriber pays the member liability = deductible + coinsurance + copay + noncovered.

            (Part of the member liability may have already been paid to the provider as paidbypatient).

            The eligible amount - the member liability is the payment amount to the provider (paidtoprovider) or the subscriber (paidtopatient).

          )
          pass amount_calculations_note if amount_calculations_note.present?
        end

  end
end
