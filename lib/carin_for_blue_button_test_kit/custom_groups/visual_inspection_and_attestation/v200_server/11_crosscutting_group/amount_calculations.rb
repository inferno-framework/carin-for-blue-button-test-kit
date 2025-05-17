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

    run do
      identifier = SecureRandom.hex(32)

      wait(
        identifier:,
        message: <<~MESSAGE
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

          [Click here](#{resume_pass_url}?token=#{identifier}) if the system **meets** these requirements.

          [Click here](#{resume_fail_url}?token=#{identifier}) if the system **does not meet** these requirements.
        MESSAGE
      )
    end
  end
end
