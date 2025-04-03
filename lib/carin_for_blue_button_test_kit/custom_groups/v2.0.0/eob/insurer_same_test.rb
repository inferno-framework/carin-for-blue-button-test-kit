# frozen_string_literal: true
require 'pry'
require 'pry-byebug'

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
          eob.insurance.each do |insurance|
            coverage = get_reference(insurance.coverage, :coverage)

            if insurance.focal
              assert resource_id(eob.insurer) == resource_id(coverage.payor.first),
               "ExplanationOfBenefit.insurer differs from ExplanationOfBenefit.insurance.coverage.payor when ExplanationOfBenefit.insurance.focal == True. They must be equal."
            else
              assert resource_id(eob.insurer) != resource_id(coverage.payor.first),
               "ExplanationOfBenefit.insurer equals ExplanationOfBenefit.insurance.coverage.payor when ExplanationOfBenefit.insurance.focal == False. They must differ."
            end
          end
        end
      end
    end
  end
end