require_relative '../../../carin_search_test'
require_relative '../../../generator/group_metadata'

module CarinForBlueButtonTestKit
  module CARIN4BBV200
    class CoverageCoverage_payorSearchTest < Inferno::Test
      include CarinForBlueButtonTestKit::CarinSearchTest

      title 'Server returns valid results for Coverage search by id + _include=Coverage:payor'
      description %(Tests that the server responds correctly when using _include="Coverage:payor" as a search parameter 

      )

      def self.properties
        @properties ||= SearchTestProperties.new(
          resource_type: 'Coverage',
        search_param_names: ['_include'],
        include_parameters: [{:path=>"payor", :target=>["Organization", "Patient", "RelatedPerson"]}]
        )
      end

      id :c4bb_v200_coverage_include_Coverage_payor_search_test

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:coverage_resources] ||= {}
      end

      run do
        run_include_search('Coverage:payor')
      end
    end
  end
end
