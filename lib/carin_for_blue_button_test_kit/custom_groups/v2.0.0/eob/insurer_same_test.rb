# frozen_string_literal: true

module CarinForBlueButtonTestKit
  module CARIN4BBV200
    class InsurerSameTest < Inferno::Test
      include CarinSearchTest

      id :c4bb_v200_custom_eob_insurer_same
      title 'ExplanationOfBenefit insurer is properly referenced in insurance list'
      description %(This test confirms that the ExplanationOfBenefit.insurer is equal to the insurance referenced
      in the ExplanationOfBenefit.insurance list with focal=True, and that ExplanationOfBenefit.insurer is not 
      equal to any insurance referenced in the ExplanationOfBenefit.insurance list with focal=False.
      )

      verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@116',
                            'hl7.fhir.us.carin-bb_2.0.0@124',
                            'hl7.fhir.us.carin-bb_2.0.0@125',
                            'hl7.fhir.us.carin-bb_2.0.0@127',
                            'hl7.fhir.us.carin-bb_2.0.0@128',
                            'hl7.fhir.us.carin-bb_2.0.0@129'

      def resource_type
        'ExplanationOfBenefit'
      end

      def scratch_resources
        scratch[:explanationofbenefit_resources] ||= {}
      end

      def get_reference(reference, type)
        reference_id = resource_id(reference)
        fhir_read(type, reference_id)
        return resource
      end

      run do
        resources = scratch_resources[:all]
        skip_if resources.blank?,
                "No #{resource_type} resources were returned"

        resources.each do |eob|
          eob.insurance.each_with_index do |eob_insurance, index|
            eob_insurance_coverage = get_reference(eob_insurance.coverage, :coverage)

            skip_if eob_insurance_coverage.nil?,
                    "No insurance coverage found for EOB #{eob.id} insurance at index #{index}"

            if eob_insurance.focal
              assert resource_id(eob.insurer) == resource_id(eob_insurance_coverage.payor.first),
                     <<~ERROR_MESSAGE1
                        ExplanationOfBenefit.insurer.reference differs from
                        ExplanationOfBenefit.insurance.coverage.reference -> Coverage.payor[0].reference
                        when ExplanationOfBenefit.insurance.focal == True. They must be equal.
                      ERROR_MESSAGE1
            else
              assert resource_id(eob.insurer) != resource_id(eob_insurance_coverage.payor.first),
                     <<~ERROR_MESSAGE2
                        ExplanationOfBenefit.insurer.reference equals
                        ExplanationOfBenefit.insurance.coverage.reference -> Coverage.payor[0].reference
                        when ExplanationOfBenefit.insurance.focal == False. They must differ.
                      ERROR_MESSAGE2
            end
          end
        end
      end
    end
  end
end
