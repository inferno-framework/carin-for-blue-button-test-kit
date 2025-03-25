# frozen_string_literal: true
module CarinForBlueButtonTestKit
  module CARIN4BBV200
    class InsurerSameTest < Inferno::Test
      id :c4bb_v200_custom_eob_insurer_same
      title 'ExplanationOfBenefit insurer is consistent'
      description %(ExplanationOfBenefit.insurer is the same as ExplanationOfBenefit.insurance.coverage.organization.
      )
      
      verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@116'

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
          for insurance in resource.insurance
            if insurance.focal
              # TODO: insurer is a reference and coverage is a reference. Need to be able to access the referenced information to complete this
              assert resource.insurer == insurance.coverage.organization,
               "ExplanationOfBenefit.insurer differs from ExplanationOfBenefit.insurance.coverage.organization."
            end
          end
        end
      end
    end
  end
end