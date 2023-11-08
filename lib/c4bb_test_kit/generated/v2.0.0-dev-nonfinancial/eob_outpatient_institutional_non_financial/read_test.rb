require_relative '../../../read_test'
require 'json'

module C4BBTestKit
  module CARIN4BBV200DEVNONFINANCIAL
    class EobOutpatientInstitutionalNonFinancialReadTest < Inferno::Test
      include C4BBTestKit::ReadTest

      title 'Server returns correct ExplanationOfBenefit resource from ExplanationOfBenefit read interaction'
      description 'A server SHALL support the ExplanationOfBenefit read interaction.'

      id :c4bb_v200devnonfinancial_eob_outpatient_institutional_non_financial_read_test

      input :eob_outpatient_institutional_non_financial_ids,
        title: "eob_outpatient_institutional_non_financial IDs",
        type: 'text',
        description: "eob_outpatient_institutional_non_financial Resource ID"

      input_order :url, :smart_credentials, :eob_outpatient_institutional_non_financial_ids

      def resource_type
        'ExplanationOfBenefit'
      end

      def scratch_resources
        scratch[:eob_outpatient_institutional_non_financial_resources] ||= {}
      end

      def eob_outpatient_institutional_non_financial_id_list
        return [nil] unless respond_to? :eob_outpatient_institutional_non_financial_ids
        eob_outpatient_institutional_non_financial_ids.split(',').map(&:strip)
      end

      run do
        perform_read_test(eob_outpatient_institutional_non_financial_id_list)
      end
    end
  end
end
