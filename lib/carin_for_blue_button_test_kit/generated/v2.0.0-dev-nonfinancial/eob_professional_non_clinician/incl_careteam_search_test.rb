require_relative '../../../carin_search_test'
require_relative '../../../generator/group_metadata'

module CarinForBlueButtonTestKit
  module CARIN4BBV200DEVNONFINANCIAL
    class EobProfessionalNonClinicianExplanationOfBenefit_careteamSearchTest < Inferno::Test
      include CarinForBlueButtonTestKit::CarinSearchTest

      title 'Server returns valid results for ExplanationOfBenefit search by id + _include=ExplanationOfBenefit:care-team'
      description %(Tests that the server responds correctly when using _include="ExplanationOfBenefit:care-team" as a search parameter 

      )

      def self.properties
        @properties ||= SearchTestProperties.new(
          resource_type: 'ExplanationOfBenefit',
        search_param_names: ['_include'],
        include_parameters: [{:path=>"careTeam.provider", :target=>["Practitioner", "Organization", "PractitionerRole"]}]
        )
      end

      id :c4bb_v200devnonfinancial_eob_professional_non_clinician_include_ExplanationOfBenefit_careteam_search_test

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:explanationofbenefit_resources] ||= {}
      end

      run do
        run_include_search('ExplanationOfBenefit:care-team')
      end
    end
  end
end
