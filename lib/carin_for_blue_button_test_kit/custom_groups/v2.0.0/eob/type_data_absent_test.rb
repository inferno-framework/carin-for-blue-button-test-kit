# frozen_string_literal: true
module CarinForBlueButtonTestKit
  module CARIN4BBV200
    class TypeDataAbsentTest < Inferno::Test
      id :c4bb_v200_custom_eob_type_data_absent
      title 'ExplanationOfBenefit.type does not use a data absent reason'
      description %(
        ExplanationOfBenefit.type SHALL NOT use a data absent reason.
      )
      
      verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@115'

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
          eob_type = resource.type
          eob_type.coding.each do |coding|
            assert !(coding.code == 'unknown' && coding.system == DAR_CODE_SYSTEM_URL), 'ExplanationOfBenefit.type uses a data absent reason'
          end
        end
      end
    end
  end
end