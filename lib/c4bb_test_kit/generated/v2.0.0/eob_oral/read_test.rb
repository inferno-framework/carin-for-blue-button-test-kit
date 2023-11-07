require_relative '../../../read_test'
require 'json'

module CarinForBlueButtonTestKit
  module CARIN4BBV200
    class EobOralReadTest < Inferno::Test
      include CarinForBlueButtonTestKit::ReadTest

      title 'Server returns correct ExplanationOfBenefit resource from ExplanationOfBenefit read interaction'
      description 'A server SHALL support the ExplanationOfBenefit read interaction.'

      id :c4bb_v200_eob_oral_read_test

      input :eob_oral_ids,
        title: "eob_oral IDs",
        type: 'text',
        description: "eob_oral Resource ID"

      input_order :url, :smart_credentials, :eob_oral_ids

      def resource_type
        'ExplanationOfBenefit'
      end

      def scratch_resources
        scratch[:eob_oral_resources] ||= {}
      end

      def eob_oral_id_list
        return [nil] unless respond_to? :eob_oral_ids
        eob_oral_ids.split(',').map(&:strip)
      end

      run do
        perform_read_test(eob_oral_id_list)
      end
    end
  end
end
