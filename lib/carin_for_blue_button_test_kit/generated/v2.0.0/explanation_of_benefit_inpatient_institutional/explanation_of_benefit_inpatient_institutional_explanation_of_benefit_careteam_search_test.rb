require_relative '../../../carin_search_test'
require_relative '../../../generator/group_metadata'

module CarinForBlueButtonTestKit
  module CARIN4BBV200
    class ExplanationOfBenefitInpatientInstitutionalExplanationOfBenefit_careteamSearchTest < Inferno::Test
      include CarinForBlueButtonTestKit::CarinSearchTest

      title 'Server returns valid results for ExplanationOfBenefit search by id + _include=ExplanationOfBenefit:care-team'
      description %(
Tests that the server responds correctly when using _include="ExplanationOfBenefit:care-team" as a search parameter

      )

      def self.properties
        @properties ||= SearchTestProperties.new(
          resource_type: 'ExplanationOfBenefit',
        search_param_names: ['_include']
        )
      end

      id :c4bb_v200_explanation_of_benefit_inpatient_institutional_include_ExplanationOfBenefit_careteam_search_test

      input :explanation_of_benefit_inpatient_institutional_ids,
        title: 'explanation_of_benefit_inpatient_institutional IDs',
        type: 'text',
        description: 'Comma separated list of explanation_of_benefit_inpatient_institutional IDs that in sum contain all MUST SUPPORT elements'

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def explanation_of_benefit_inpatient_institutional_ids_string_formatter
        return [nil] unless respond_to? :explanation_of_benefit_inpatient_institutional_ids
        explanation_of_benefit_inpatient_institutional_ids.split(',').map(&:strip).join(',')
      end

      run do
        run_search_test('ExplanationOfBenefit:care-team', include_search: true, resource_id: explanation_of_benefit_inpatient_institutional_ids_string_formatter)
      end
    end
  end
end
