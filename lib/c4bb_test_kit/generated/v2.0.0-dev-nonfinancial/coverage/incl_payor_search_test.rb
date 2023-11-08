require_relative '../../../carin_search_test'
require_relative '../../../generator/group_metadata'

module C4BBTestKit
  module CARIN4BBV200DEVNONFINANCIAL
    class CoverageCoverage_payorSearchTest < Inferno::Test
      include C4BBTestKit::CarinSearchTest

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

      id :c4bb_v200devnonfinancial_coverage_include_Coverage_payor_search_test

      input :c4bb_v200devnonfinancial_coverage__id_search_test_param,
        title: 'Coverage search parameter for _id',
        type: 'text',
        description: 'Coverage search parameter: _id'

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      run do
        run_include_search('Coverage:payor', resource_id: c4bb_v200devnonfinancial_coverage__id_search_test_param)
      end
    end
  end
end
