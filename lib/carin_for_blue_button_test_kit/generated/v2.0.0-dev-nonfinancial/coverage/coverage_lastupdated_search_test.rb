require_relative '../../../carin_search_test'
require_relative '../../../generator/group_metadata'

module CarinForBlueButtonTestKit
  module CARIN4BBV200DEVNONFINANCIAL
    class CoverageLastupdatedSearchTest < Inferno::Test
      include CarinForBlueButtonTestKit::CarinSearchTest

      title 'Server returns valid results for Coverage search by _lastUpdated'
      description %(
        A server SHOULD support searching by
        _lastUpdated on the Coverage resource. This test
        will pass if resources are returned and match the search criteria. If
        none are returned, the test is skipped.
      )

      id :c4bb_v200devnonfinancial_coverage__lastUpdated_search_test

      input :c4bb_v200devnonfinancial_coverage__lastUpdated_search_test_param,
        title: 'Coverage search parameter for _lastUpdated
',
        type: 'text',
        description: 'Coverage search parameter: _lastUpdated
'

      def self.properties
        @properties ||= SearchTestProperties.new(
          resource_type: 'Coverage',
        search_param_names: ['_lastUpdated']
        )
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:coverage_resources] ||= {}
      end

      run do
        run_search_test(c4bb_v200devnonfinancial_coverage__lastUpdated_search_test_param)
      end
    end
  end
end
