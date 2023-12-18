require_relative '../../../read_test'
require 'json'

module CarinForBlueButtonTestKit
  module CARIN4BBV200DEVNONFINANCIAL
    class CoverageReadTest < Inferno::Test
      include CarinForBlueButtonTestKit::ReadTest

      title 'Server returns correct Coverage resource from Coverage read interaction'
      description 'A server SHALL support the Coverage read interaction.'

      id :c4bb_v200devnonfinancial_coverage_read_test
      
      def resource_type
        'Coverage'
      end

      def scratch_resources
        scratch[:coverage_resources] ||= {}
      end

      def resource_ids
        return [] unless respond_to? :additional_coverage_ids
        additional_coverage_ids.split(',').map(&:strip)
      end

      run do
        perform_read_test(scratch.dig(:references, 'Coverage'))
      end
    end
  end
end
