require_relative '../../../read_test'
require 'json'

module CarinForBlueButtonTestKit
  module CARIN4BBV110
    class OrganizationReadTest < Inferno::Test
      include CarinForBlueButtonTestKit::ReadTest

      title 'Server returns correct Organization resource from Organization read interaction'
      description 'A server SHALL support the Organization read interaction.'

      id :c4bb_v110_organization_read_test
      
      input :additional_organization_ids,
        title: "Additional organization IDs",
        type: 'text',
        description: "organization Resource ID. This is optional, but must be provided if executing only the Organization test group.",
        optional: true
      
      def resource_type
        'Organization'
      end

      def scratch_resources
        scratch[:organization_resources] ||= {}
      end

      def resource_ids
        return [] unless respond_to? :additional_organization_ids
        additional_organization_ids.split(',').map(&:strip)
      end

      run do
        perform_read_test(scratch.dig(:references, 'Organization'))
      end
    end
  end
end
