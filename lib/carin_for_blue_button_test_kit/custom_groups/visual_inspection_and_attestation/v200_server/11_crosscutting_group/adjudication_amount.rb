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
            -  C4BB ExplanationOfBenefit Inpatient Institutional `.adjudication.amount`
            -  C4BB ExplanationOfBenefit Outpatient Institutional `.adjudication.amount`

          The developer of the Health IT Module attests that the Health IT Module only populates
          `.adjudication.amount` if `.item.adjudication` is not available.

          [Click here](#{resume_pass_url}?token=#{identifier}) if the system **meets** this requirement.

          [Click here](#{resume_fail_url}?token=#{identifier}) if the system **does not meet** this requirement.
        MESSAGE
      )
    end
  end
end
