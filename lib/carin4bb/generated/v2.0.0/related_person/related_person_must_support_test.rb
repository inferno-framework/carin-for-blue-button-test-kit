require_relative '../../../must_support_test'
require_relative './related_person_read_test'
require_relative '../../../generator/group_metadata'

module CARINForBlueButton
  module CARIN4BBV200
    class RelatedPersonMustSupportTest < Inferno::Test
      include CARINForBlueButton::MustSupportTest
      include CARINForBlueButton::CARIN4BBV200

      title 'All must support elements are provided in the RelatedPerson resources returned'
      description %(
        CARIN for Blue Button Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the CARIN for Blue Button Capability
        Statement. This test will look through the RelatedPerson resources
        found previously for the following must support elements:

        * RelatedPerson.active
        * RelatedPerson.address
        * RelatedPerson.meta
        * RelatedPerson.meta.lastUpdated
        * RelatedPerson.name
        * RelatedPerson.patient
        * RelatedPerson.relationship
        * RelatedPerson.telecom
      )

      id :c4bb_v200_related_person_must_support_test

      #uses_request :related_person_request

      def resource_type
        'RelatedPerson'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:related_person_resources] ||= {}
      end

      def related_person_resource
        CARIN4BBV200::RelatedPersonReadTest.new().related_person_resource
      end 

      run do
        perform_must_support_test([related_person_resource])
      end
    end
  end
end
