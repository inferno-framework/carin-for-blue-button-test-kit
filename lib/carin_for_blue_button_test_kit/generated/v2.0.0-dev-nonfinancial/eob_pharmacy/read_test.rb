require_relative '../../../read_test'
require 'json'

module CarinForBlueButtonTestKit
  module CARIN4BBV200DEVNONFINANCIAL
    class EobPharmacyReadTest < Inferno::Test
      include CarinForBlueButtonTestKit::ReadTest

      title 'Server returns correct ExplanationOfBenefit resource from ExplanationOfBenefit read interaction'
      description 'A server SHALL support the ExplanationOfBenefit read interaction.'

      id :c4bb_v200devnonfinancial_eob_pharmacy_read_test
      
      def resource_type
        'ExplanationOfBenefit'
      end

      def scratch_resources
        scratch[:explanationofbenefit_resources] ||= {}
      end

      def resource_ids
        return [] unless respond_to? :additional_eob_pharmacy_ids
        additional_eob_pharmacy_ids.split(',').map(&:strip)
      end

      run do
        perform_read_test(all_scratch_resources)
      end
    end
  end
end
