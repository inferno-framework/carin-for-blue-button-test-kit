require_relative '../../../carin_search_test'
require_relative '../../../generator/group_metadata'

module CarinForBlueButtonTestKit
  module CARIN4BBV200DEVNONFINANCIAL
    class ExplanationOfBenefitProfessionalNonClinicianExplanationOfBenefit_providerSearchTest < Inferno::Test
      include CarinForBlueButtonTestKit::CarinSearchTest

      title 'Server returns valid results for ExplanationOfBenefit search by id + _include=ExplanationOfBenefit:provider'
      description %(Tests that the server responds correctly when using _include="ExplanationOfBenefit:provider" as a search parameter 

      )

      def self.properties
        @properties ||= SearchTestProperties.new(
          resource_type: 'ExplanationOfBenefit',
        search_param_names: ['_include']
        )
      end

      id :c4bb_v200devnonfinancial_explanation_of_benefit_professional_non_clinician_include_ExplanationOfBenefit_provider_search_test

      input :c4bb_v200devnonfinancial_explanation_of_benefit_professional_non_clinician__id_search_test_param,
        title: 'ExplanationOfBenefit search parameter for _id',
        type: 'text',
        description: 'ExplanationOfBenefit search parameter: _id'

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      run do
        run_include_search('ExplanationOfBenefit:provider', resource_id: c4bb_v200devnonfinancial_explanation_of_benefit_professional_non_clinician__id_search_test_param)
      end
    end
  end
end
