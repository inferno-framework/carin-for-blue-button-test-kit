require_relative '../../../read_test'
require 'json'

module C4BBTestKit
  module CARIN4BBV110
    class CoverageReadTest < Inferno::Test
      include C4BBTestKit::ReadTest

      title 'Server returns correct Coverage resource from Coverage read interaction'
      description 'A server SHALL support the Coverage read interaction.'

      id :c4bb_v110_coverage_read_test

      input :coverage_ids,
        title: "coverage IDs",
        type: 'text',
        description: "coverage Resource ID"

      input_order :url, :smart_credentials, :coverage_ids

      def resource_type
        'Coverage'
      end

      def scratch_resources
        scratch[:coverage_resources] ||= {}
      end

      def coverage_id_list
        return [nil] unless respond_to? :coverage_ids
        coverage_ids.split(',').map(&:strip)
      end

      run do
        perform_read_test(coverage_id_list)
      end
    end
  end
end
