require_relative '../../../carin_search_test'
require_relative '../../../generator/group_metadata'

module CARINForBlueButton
  module CARIN4BBV200
    class ExplanationOfBenefitOutpatientInstitutionalExplanationOfBenefit_insurerSearchTest < Inferno::Test
      include CARINForBlueButton::CarinSearchTest

      title 'Server returns valid results for ExplanationOfBenefit search by _include=ExplanationOfBenefit:insurer'
      description %(
Tests that the server responds correctly when using _include="ExplanationOfBenefit:insurer" as a search parameter 

      )

      def self.properties
        @properties ||= SearchTestProperties.new(
          resource_type: 'ExplanationOfBenefit',
        search_param_names: ['_include']
        )
      end

      id :c4bb_v200_explanation_of_benefit_outpatient_institutional_include_ExplanationOfBenefit_insurer_search_test

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      run do
        run_search_test('ExplanationOfBenefit:insurer', include_search: true)
      end
    end
  end
end