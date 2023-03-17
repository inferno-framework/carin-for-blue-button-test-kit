require_relative '../../../carin_search_test'
require_relative '../../../generator/group_metadata'

module CARINForBlueButton
  module CARIN4BBV120
    class CoverageIdSearchTest < Inferno::Test
      include CARINForBlueButton::CarinSearchTest

      title 'Server returns valid results for Coverage search by _id'
      description %(
A server SHALL support searching by
_id on the Coverage resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

Because this is the first search of the sequence, resources in the
response will be used for subsequent tests.

Additionally, this test will check that GET and POST search methods
return the same number of results. Search by POST is required by the
FHIR R4 specification, and these tests interpret search by GET as a
requirement of US Core v1.2.0.


      )

      id :c4bb_v120_coverage__id_search_test
      optional

      input :patient_ids

      input :coverage__id_parameter,
        title: "Searchable Coverage ID",
        type: 'text',
        description: "Coverage ID for search"
      
      def self.properties
        @properties ||= SearchTestProperties.new(
          first_search: true,
        resource_type: 'Coverage',
        search_param_names: ['_id'],
        saves_delayed_references: true,
        test_post_search: true
        )
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:coverage_resources] ||= {}
      end

      run do
        run_search_test(coverage__id_parameter)
      end
    end
  end
end
