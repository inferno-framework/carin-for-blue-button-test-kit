require_relative '../../../search_test'
require_relative '../../../generator/group_metadata'

module CARINForBlueButton
  module CARIN4BBV120
    class ExplanationOfBenefitIdSearchTest < Inferno::Test
      include CARINForBlueButton::SearchTest

      title 'Server returns valid results for ExplanationOfBenefit search by _id'
      description %(
A server SHALL support searching by
_id on the ExplanationOfBenefit resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

Because this is the first search of the sequence, resources in the
response will be used for subsequent tests.

Additionally, this test will check that GET and POST search methods
return the same number of results. Search by POST is required by the
FHIR R4 specification, and these tests interpret search by GET as a
requirement of US Core v1.2.0.


      )

      id :c4bb_v120_explanation_of_benefit__id_search_test
      optional
  
      def self.properties
        @properties ||= SearchTestProperties.new(
          first_search: true,
        resource_type: 'ExplanationOfBenefit',
        search_param_names: ['_id'],
        saves_delayed_references: true,
        test_post_search: true
        )
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:explanation_of_benefit_resources] ||= {}
      end

      run do
        run_search_test
      end
    end
  end
end
