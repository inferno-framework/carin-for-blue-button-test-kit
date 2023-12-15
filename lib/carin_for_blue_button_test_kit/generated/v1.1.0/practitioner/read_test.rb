require_relative '../../../read_test'
require 'json'

module CarinForBlueButtonTestKit
  module CARIN4BBV110
    class PractitionerReadTest < Inferno::Test
      include CarinForBlueButtonTestKit::ReadTest

      title 'Server returns correct Practitioner resource from Practitioner read interaction'
      description 'A server SHALL support the Practitioner read interaction.'

      id :c4bb_v110_practitioner_read_test
      
      input :additional_practitioner_ids,
        title: "Additional practitioner IDs",
        type: 'text',
        description: "practitioner Resource ID. This is optional, but must be provided if executing only the Practitioner test group.",
        optional: true
      
      def resource_type
        'Practitioner'
      end

      def scratch_resources
        scratch[:practitioner_resources] ||= {}
      end

      def resource_ids
        return [] unless respond_to? :additional_practitioner_ids
        additional_practitioner_ids.split(',').map(&:strip)
      end

      run do
        perform_read_test(scratch.dig(:references, 'Practitioner'))
      end
    end
  end
end
