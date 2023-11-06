require_relative '../../../read_test'
require 'json'

module CarinForBlueButtonTestKit
  module CARIN4BBV200
    class EobPharmacyReadTest < Inferno::Test
      include CarinForBlueButtonTestKit::ReadTest

      title 'Server returns correct ExplanationOfBenefit resource from ExplanationOfBenefit read interaction'
      description 'A server SHALL support the ExplanationOfBenefit read interaction.'

      id :c4bb_v200_eob_pharmacy_read_test

      input :eob_pharmacy_ids,
        title: "eob_pharmacy IDs",
        type: 'text',
        description: "eob_pharmacy Resource ID"

      input_order :url, :smart_credentials, :eob_pharmacy_ids

      def resource_type
        'ExplanationOfBenefit'
      end

      def scratch_resources
        scratch[:eob_pharmacy_resources] ||= {}
      end

      def eob_pharmacy_id_list
        return [nil] unless respond_to? :eob_pharmacy_ids
        eob_pharmacy_ids.split(',').map(&:strip)
      end

      run do
        perform_read_test(eob_pharmacy_id_list)
      end
    end
  end
end
