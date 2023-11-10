require_relative '../../../carin_search_test'
require_relative '../../../generator/group_metadata'

module CarinForBlueButtonTestKit
  module CARIN4BBV110
    class ExplanationOfBenefitTypeSearchTest < Inferno::Test
      include CarinForBlueButtonTestKit::CarinSearchTest

      title 'Server returns valid results for ExplanationOfBenefit search by type'
      description %(A server SHALL support searching by
type on the ExplanationOfBenefit resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.


      )

      id :c4bb_v110_explanation_of_benefit_type_search_test

      input :c4bb_v110_explanation_of_benefit_type_search_test_param,
        title: 'ExplanationOfBenefit search parameter for type
',
        type: 'text',
        description: 'ExplanationOfBenefit search parameter: type
'

      def self.properties
        @properties ||= SearchTestProperties.new(
          resource_type: 'ExplanationOfBenefit',
        search_param_names: ['type'],
        token_search_params: ['type']
        )
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:explanation_of_benefit_resources] ||= {}
      end

      run do
        
        run_search_test(c4bb_v110_explanation_of_benefit_type_search_test_param)
      end
    end
  end
end
