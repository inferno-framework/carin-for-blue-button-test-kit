require_relative '../../../read_test'
require 'json'

module CarinForBlueButtonTestKit
  module CARIN4BBV200DEVNONFINANCIAL
    class CoverageReadTest < Inferno::Test
      include CarinForBlueButtonTestKit::ReadTest

      title 'Server returns correct Coverage resource from Coverage read interaction'
      description 'A server SHALL support the Coverage read interaction.'

      id :c4bb_v200devnonfinancial_coverage_read_test

      input :coverage_ids,
        title: "coverage IDs",
        type: 'text',
        description: "Comma separated list of coverage IDs that in sum contain all MUST SUPPORT elements"

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
