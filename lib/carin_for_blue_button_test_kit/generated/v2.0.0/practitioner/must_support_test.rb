require_relative '../../../must_support_test'
require_relative './read_test'
require_relative '../../../generator/group_metadata'

module CarinForBlueButtonTestKit
  module CARIN4BBV200
    class PractitionerMustSupportTest < Inferno::Test
      include CarinForBlueButtonTestKit::MustSupportTest
      include CarinForBlueButtonTestKit::CARIN4BBV200

      title 'All must support elements are provided in the Practitioner resources returned'
      description %(
        CARIN for Blue Button Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the CARIN for Blue Button Capability
        Statement. This test will look through the Practitioner resources
        found previously for the following must support elements:

                * Practitioner.identifier
        * Practitioner.identifier:NPI
        * Practitioner.identifier:tax
        * Practitioner.meta
        * Practitioner.meta.lastUpdated
        * Practitioner.name
        * Practitioner.name.family
      )

      id :c4bb_v200_practitioner_must_support_test

      def resource_type
        'Practitioner'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:practitioner_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
