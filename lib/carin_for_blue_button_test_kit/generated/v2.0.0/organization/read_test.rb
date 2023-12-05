require_relative '../../../read_test'
require 'json'

module CarinForBlueButtonTestKit
  module CARIN4BBV200
    class OrganizationReadTest < Inferno::Test
      include CarinForBlueButtonTestKit::ReadTest

      title 'Server returns correct Organization resource from Organization read interaction'
      description 'A server SHALL support the Organization read interaction.'

      id :c4bb_v200_organization_read_test
      
      input :organization_ids,
        title: "organization IDs",
        type: 'text',
        description: "organization Resource ID"
      
      input_order :url, :smart_credentials, :organization_ids

      def resource_type
        'Organization'
      end

      def scratch_resources
        scratch[:organization_resources] ||= {}
      end

      def organization_id_list
        return [] unless respond_to? :organization_ids
        organization_ids.split(',').map(&:strip)
      end

      run do
        perform_read_test(organization_id_list)
      end
    end
  end
end
