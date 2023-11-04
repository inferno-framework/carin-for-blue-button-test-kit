require_relative '../../../carin_search_test'
require_relative '../../../generator/group_metadata'

module CarinForBlueButtonTestKit
  module CARIN4BBV110
    class ExplanationOfBenefitPharmacyExplanationOfBenefit_AllSearchTest < Inferno::Test
      include CarinForBlueButtonTestKit::CarinSearchTest

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

      id :c4bb_v110_explanation_of_benefit_pharmacy_include_ExplanationOfBenefit_All_search_test

      input :explanation_of_benefit_pharmacy_ids,
        title: 'explanation_of_benefit_pharmacy IDs',
        type: 'text',
        description: 'Comma separated list of explanation_of_benefit_pharmacy IDs that in sum contain all MUST SUPPORT elements'

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def explanation_of_benefit_pharmacy_ids_string_formatter
        return [nil] unless respond_to? :explanation_of_benefit_pharmacy_ids
        explanation_of_benefit_pharmacy_ids.split(',').map(&:strip).join(',')
      end

      run do
        run_search_test('ExplanationOfBenefit:*', include_search: true, resource_id: explanation_of_benefit_pharmacy_ids_string_formatter)
      end
    end
  end
end
