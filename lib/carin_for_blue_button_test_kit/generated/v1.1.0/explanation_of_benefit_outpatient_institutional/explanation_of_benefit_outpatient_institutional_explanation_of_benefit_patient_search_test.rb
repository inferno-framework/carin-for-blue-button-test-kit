require_relative '../../../carin_search_test'
require_relative '../../../generator/group_metadata'

module CarinForBlueButtonTestKit
  module CARIN4BBV110
    class ExplanationOfBenefitOutpatientInstitutionalExplanationOfBenefit_patientSearchTest < Inferno::Test
      include CarinForBlueButtonTestKit::CarinSearchTest

      title 'Server returns valid results for ExplanationOfBenefit search by id + _include=ExplanationOfBenefit:patient'
      description %(Tests that the server responds correctly when using _include="ExplanationOfBenefit:patient" as a search parameter 

      )

      def self.properties
        @properties ||= SearchTestProperties.new(
          resource_type: 'ExplanationOfBenefit',
        search_param_names: ['_include'],
        include_parameters: [{:path=>"patient", :target=>["Patient"]}]
        )
      end

      id :c4bb_v110_explanation_of_benefit_outpatient_institutional_include_ExplanationOfBenefit_patient_search_test

      input :c4bb_v110_explanation_of_benefit_outpatient_institutional__id_search_test_param,
        title: 'ExplanationOfBenefit search parameter for _id',
        type: 'text',
        description: 'ExplanationOfBenefit search parameter: _id'

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      run do
        run_include_search('ExplanationOfBenefit:patient', resource_id: c4bb_v110_explanation_of_benefit_outpatient_institutional__id_search_test_param)
      end
    end
  end
end
