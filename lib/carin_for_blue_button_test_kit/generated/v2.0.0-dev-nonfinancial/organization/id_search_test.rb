require_relative '../../../carin_search_test'
require_relative '../../../generator/group_metadata'

module CarinForBlueButtonTestKit
  module CARIN4BBV200DEVNONFINANCIAL
    class OrganizationIdSearchTest < Inferno::Test
      include CarinForBlueButtonTestKit::CarinSearchTest

      title 'Server returns valid results for Organization search by _id'
      description %(A server SHALL support searching by
_id on the Organization resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

Because this is the first search of the sequence, resources in the
response will be used for subsequent tests.

Additionally, this test will check that GET and POST search methods
return the same number of results. Search by POST is required by the
FHIR R4 specification, and these tests interpret search by GET as a
requirement of CARIN IG for Blue Button® v2.0.0-dev-nonfinancial.


      )

      id :c4bb_v200devnonfinancial_organization__id_search_test
      
      input :c4bb_v200devnonfinancial_organization__id_search_test_param,
        title: 'Organization search parameter for _id',
        type: 'text',
        description: %q(
          
This input is optional. If running all tests, the search will look for
its parameter values from the results returned in the EOB tests. If no
Organization resource was returned in previous EOB tests and this
input is not provided, the search is skipped.

When running just the Organization Test group, this input is
required to perform the search, otherwise the search is skipped.

        ),
        optional: true
      
      def self.properties
        @properties ||= SearchTestProperties.new(
          first_search: true,
          resource_type: 'Organization',
          search_param_names: ['_id'],
          test_post_search: true
        )
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:organization_resources] ||= {}
      end

      run do
        run_search_test(c4bb_v200devnonfinancial_organization__id_search_test_param)
      end
    end
  end
end
