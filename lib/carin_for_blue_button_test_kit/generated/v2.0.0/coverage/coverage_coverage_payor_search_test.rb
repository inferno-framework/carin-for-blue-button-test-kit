require_relative '../../../carin_search_test'
require_relative '../../../generator/group_metadata'

module CarinForBlueButtonTestKit
  module CARIN4BBV200
    class CoverageCoverage_payorSearchTest < Inferno::Test
      include CarinForBlueButtonTestKit::CarinSearchTest

      title 'Server returns valid results for Coverage search by id + _include=Coverage:payor'
      description %(
Tests that the server responds correctly when using _include="Coverage:payor" as a search parameter

      )

      def self.properties
        @properties ||= SearchTestProperties.new(
          resource_type: 'Coverage',
        search_param_names: ['_include']
        )
      end

      id :c4bb_v200_coverage_include_Coverage_payor_search_test

      input :coverage_ids,
        title: 'coverage IDs',
        type: 'text',
        description: 'Comma separated list of coverage IDs that in sum contain all MUST SUPPORT elements'

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def coverage_ids_string_formatter
        return [nil] unless respond_to? :coverage_ids
        coverage_ids.split(',').map(&:strip).join(',')
      end

      run do
        run_search_test('Coverage:payor', include_search: true, resource_id: coverage_ids_string_formatter)
      end
    end
  end
end
