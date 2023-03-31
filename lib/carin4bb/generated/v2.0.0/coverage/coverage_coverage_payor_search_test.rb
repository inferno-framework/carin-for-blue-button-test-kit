require_relative '../../../carin_search_test'
require_relative '../../../generator/group_metadata'

module CARINForBlueButton
  module CARIN4BBV200
    class CoverageCoverage_payorSearchTest < Inferno::Test
      include CARINForBlueButton::CarinSearchTest

      title 'Server returns valid results for Coverage search by _include=Coverage:payor'
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

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      run do
        run_search_test('Coverage:payor', include_search: true)
      end
    end
  end
end