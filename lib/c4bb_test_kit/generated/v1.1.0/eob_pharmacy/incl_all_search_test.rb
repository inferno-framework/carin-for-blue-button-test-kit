require_relative '../../../carin_search_test'
require_relative '../../../generator/group_metadata'

module C4BBTestKit
  module CARIN4BBV110
    class EobPharmacyExplanationOfBenefit_AllSearchTest < Inferno::Test
      include C4BBTestKit::CarinSearchTest

      title 'Server returns valid results for ExplanationOfBenefit search by id + _include=ExplanationOfBenefit:*'
      description %(
Tests that the server responds correctly when using _include="ExplanationOfBenefit:*" as a search parameter 

      )

      def self.properties
        @properties ||= SearchTestProperties.new(
          resource_type: 'ExplanationOfBenefit',
        search_param_names: ['_include']
        )
      end

      id :c4bb_v110_eob_pharmacy_include_ExplanationOfBenefit_All_search_test

      input :c4bb_v110_eob_pharmacy__id_search_test_param,
        title: 'ExplanationOfBenefit search parameter for _id',
        type: 'text',
        description: 'ExplanationOfBenefit search parameter: _id'

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      run do
        run_search_test('ExplanationOfBenefit:*', include_search: true, resource_id: c4bb_v110_eob_pharmacy__id_search_test_param)
      end
    end
  end
end
