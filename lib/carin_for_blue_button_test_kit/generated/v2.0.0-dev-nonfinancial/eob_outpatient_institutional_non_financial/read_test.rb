require_relative '../../../read_test'
require 'json'

module CarinForBlueButtonTestKit
  module CARIN4BBV200DEVNONFINANCIAL
    class EobOutpatientInstitutionalNonFinancialReadTest < Inferno::Test
      include CarinForBlueButtonTestKit::ReadTest

      title 'Server returns correct ExplanationOfBenefit resource from ExplanationOfBenefit read interaction'
      description 'A server SHALL support the ExplanationOfBenefit read interaction.'

      id :c4bb_v200devnonfinancial_eob_outpatient_institutional_non_financial_read_test
      
      input_order :url, :smart_credentials, :patient_ids

      def resource_type
        'ExplanationOfBenefit'
      end

      def scratch_resources
        scratch[:explanationofbenefit_resources] ||= {}
      end

      def eob_outpatient_institutional_non_financial_id_list
        return [] unless respond_to? :eob_outpatient_institutional_non_financial_ids
        eob_outpatient_institutional_non_financial_ids.split(',').map(&:strip)
      end

      run do
        perform_read_test(eob_outpatient_institutional_non_financial_id_list)
      end
    end
  end
end
