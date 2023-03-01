require_relative '../../../search_test'
require_relative '../../../generator/group_metadata'

module InfernoTemplate
  module CARIN4BBV110
    class ExplanationOfBenefitProfessionalNonClinicianTypeSearchTest < Inferno::Test
      include InfernoTemplate::SearchTest

      title 'Server returns valid results for ExplanationOfBenefit search by type'
      description %(
A server SHALL support searching by
type on the ExplanationOfBenefit resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.


      )

      id :c4bb_v110_explanation_of_benefit_professional_non_clinician_type_search_test
      optional
  
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
        scratch[:explanation_of_benefit_professional_non_clinician_resources] ||= {}
      end

      run do
        run_search_test
      end
    end
  end
end
