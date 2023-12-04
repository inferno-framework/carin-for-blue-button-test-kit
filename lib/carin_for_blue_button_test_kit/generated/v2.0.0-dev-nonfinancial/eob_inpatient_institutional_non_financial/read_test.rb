require_relative '../../../read_test'
require 'json'

module CarinForBlueButtonTestKit
  module CARIN4BBV200DEVNONFINANCIAL
    class EobInpatientInstitutionalNonFinancialReadTest < Inferno::Test
      include CarinForBlueButtonTestKit::ReadTest

      title 'Server returns correct ExplanationOfBenefit resource from ExplanationOfBenefit read interaction'
      description 'A server SHALL support the ExplanationOfBenefit read interaction.'

      id :c4bb_v200devnonfinancial_eob_inpatient_institutional_non_financial_read_test

      input :eob_inpatient_institutional_non_financial_ids,
        title: "eob_inpatient_institutional_non_financial IDs",
        type: 'text',
        description: "eob_inpatient_institutional_non_financial Resource ID"

      input_order :url, :smart_credentials, :eob_inpatient_institutional_non_financial_ids

      def resource_type
        'ExplanationOfBenefit'
      end

      def scratch_resources
        scratch[:eob_inpatient_institutional_non_financial_resources] ||= {}
      end

      def eob_inpatient_institutional_non_financial_id_list
        return [nil] unless respond_to? :eob_inpatient_institutional_non_financial_ids
        eob_inpatient_institutional_non_financial_ids.split(',').map(&:strip)
      end

      run do
        perform_read_test(eob_inpatient_institutional_non_financial_id_list)
      end
    end
  end
end
