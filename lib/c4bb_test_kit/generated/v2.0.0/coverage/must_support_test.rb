require_relative '../../../must_support_test'
require_relative './read_test'
require_relative '../../../generator/group_metadata'

module C4BBTestKit
  module CARIN4BBV200
    class CoverageMustSupportTest < Inferno::Test
      include C4BBTestKit::MustSupportTest
      include C4BBTestKit::CARIN4BBV200

      title 'All must support elements are provided in the Coverage resources returned'
      description %(
        CARIN for Blue Button Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the CARIN for Blue Button Capability
        Statement. This test will look through the Coverage resources
        found previously for the following must support elements:

                * Coverage.beneficiary
        * Coverage.class
        * Coverage.class.name
        * Coverage.class.value
        * Coverage.class:group
        * Coverage.class:plan
        * Coverage.identifier
        * Coverage.meta
        * Coverage.meta.lastUpdated
        * Coverage.payor
        * Coverage.period
        * Coverage.relationship
        * Coverage.status
        * Coverage.subscriberId
      )

      id :c4bb_v200_coverage_must_support_test

      def resource_type
        'Coverage'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:coverage_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
