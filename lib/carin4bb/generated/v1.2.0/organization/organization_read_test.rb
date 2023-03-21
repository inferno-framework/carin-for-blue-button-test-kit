require_relative '../../../read_test'
require 'json'
require_relative '../../../ext/fhir_models'

module CARINForBlueButton
  module CARIN4BBV120
    class OrganizationReadTest < Inferno::Test
      include CARINForBlueButton::ReadTest

      title 'Server returns correct Organization resource from Organization read interaction'
      description 'A server SHALL support the Organization read interaction.'

      id :c4bb_v120_organization_read_test

      input :organization_ids,
        title: "organization IDs",
        type: 'text',
        description: "organization Resource ID"

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
