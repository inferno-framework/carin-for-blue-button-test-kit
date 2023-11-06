require_relative '../../../carin_search_test'
require_relative '../../../generator/group_metadata'

module CarinForBlueButtonTestKit
  module CARIN4BBV200DEVNONFINANCIAL
    class ExplanationOfBenefitOralExplanationOfBenefit_coverageSearchTest < Inferno::Test
      include CarinForBlueButtonTestKit::CarinSearchTest

      title 'Server returns valid results for ExplanationOfBenefit search by id + _include=ExplanationOfBenefit:coverage'
      description %(Tests that the server responds correctly when using _include="ExplanationOfBenefit:coverage" as a search parameter 

      )

      def self.properties
        @properties ||= SearchTestProperties.new(
          resource_type: 'ExplanationOfBenefit',
        search_param_names: ['_include'],
        include_parameters: [{:path=>"insurance.coverage", :target=>["Coverage"]}]
        )
      end

      id :c4bb_v200devnonfinancial_explanation_of_benefit_oral_include_ExplanationOfBenefit_coverage_search_test

      input :c4bb_v200devnonfinancial_explanation_of_benefit_oral__id_search_test_param,
        title: 'ExplanationOfBenefit search parameter for _id',
        type: 'text',
        description: 'ExplanationOfBenefit search parameter: _id'

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      run do
        run_include_search('ExplanationOfBenefit:coverage', resource_id: c4bb_v200devnonfinancial_explanation_of_benefit_oral__id_search_test_param)
      end
    end
  end
end