# frozen_string_literal: true
require 'pry'
module CarinForBlueButtonTestKit
  module CARIN4BBV200
    class OutcomeCompleteTest < Inferno::Test
      id :c4bb_v200_custom_eob_outcome_complete
      title 'ExplanationOfBenefit.outcome has value "complete"'
      description %(ExplanationOfBenefit.outcome has value "complete")

      verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@117'

      def resource_type
        'ExplanationOfBenefit'
      end

      def scratch_resources
        scratch[:explanationofbenefit_resources] ||= {}
      end

      run do
        resources = scratch_resources[:all]
  
        skip_if resources.blank?,
                "No #{resource_type} resources were returned"
  
        resources.each do |resource|
          assert resource.outcome == 'complete', "ExplanationOfBenefit.outcome was '#{resource.outcome}'. Expected 'complete'."
        end
      end
    end
  end
end