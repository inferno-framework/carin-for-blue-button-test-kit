require_relative '../../../must_support_test'
require_relative './organization_read_test'
require_relative '../../../generator/group_metadata'

module InfernoTemplate
  module CARIN4BBV200
    class OrganizationMustSupportTest < Inferno::Test
      include InfernoTemplate::MustSupportTest
      include InfernoTemplate::CARIN4BBV200

      title 'All must support elements are provided in the Organization resources returned'
      description %(
        CARIN for Blue Button Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the CARIN for Blue Button Capability
        Statement. This test will look through the Organization resources
        found previously for the following must support elements:

        * Organization.active
        * Organization.address
        * Organization.address.city
        * Organization.address.country
        * Organization.address.line
        * Organization.address.postalCode
        * Organization.address.state
        * Organization.identifier
        * Organization.identifier:NPI
        * Organization.identifier:naiccode
        * Organization.identifier:payerid
        * Organization.identifier:tax
        * Organization.meta
        * Organization.meta.lastUpdated
        * Organization.name
        * Organization.telecom
      )

      id :c4bb_v200_organization_must_support_test

      #uses_request :organization_request

      def resource_type
        'Organization'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:organization_resources] ||= {}
      end

      def organization_resource
        CARIN4BBV200::OrganizationReadTest.new().organization_resource
      end 

      run do
        perform_must_support_test([organization_resource])
      end
    end
  end
end
