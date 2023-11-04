require_relative '../../../read_test'
require 'json'

module CarinForBlueButtonTestKit
  module CARIN4BBV200DEVNONFINANCIAL
    class OrganizationReadTest < Inferno::Test
      include CarinForBlueButtonTestKit::ReadTest

      title 'Server returns correct Organization resource from Organization read interaction'
      description 'A server SHALL support the Organization read interaction.'

      id :c4bb_v200devnonfinancial_organization_read_test

      input :organization_ids,
        title: "organization IDs",
        type: 'text',
        description: "Comma separated list of organization IDs that in sum contain all MUST SUPPORT elements"

      input_order :url, :smart_credentials, :organization_ids

      def resource_type
        'Organization'
      end

      def scratch_resources
        scratch[:organization_resources] ||= {}
      end

      def organization_id_list
        return [nil] unless respond_to? :organization_ids
        organization_ids.split(',').map(&:strip)
      end

      run do
        perform_read_test(organization_id_list)
      end
    end
  end
end
