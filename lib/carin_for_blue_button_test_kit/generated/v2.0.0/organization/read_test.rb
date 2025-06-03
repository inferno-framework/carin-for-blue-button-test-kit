# frozen_string_literal: true

require_relative '../../../read_test'
require 'json'

module CarinForBlueButtonTestKit
  module CARIN4BBV200
    class OrganizationReadTest < Inferno::Test
      include CarinForBlueButtonTestKit::ReadTest

      title 'Server returns correct Organization resource from Organization read interaction'
      description 'A server SHALL support the Organization read interaction.'

      id :c4bb_v200_organization_read_test

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
