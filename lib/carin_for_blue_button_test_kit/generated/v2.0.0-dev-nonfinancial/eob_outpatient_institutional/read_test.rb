require_relative '../../../read_test'
require 'json'

module CarinForBlueButtonTestKit
  module CARIN4BBV200DEVNONFINANCIAL
    class EobOutpatientInstitutionalReadTest < Inferno::Test
      include CarinForBlueButtonTestKit::ReadTest

      title 'Server returns correct ExplanationOfBenefit resource from ExplanationOfBenefit read interaction'
      description 'A server SHALL support the ExplanationOfBenefit read interaction.'

      id :c4bb_v200devnonfinancial_eob_outpatient_institutional_read_test

      input :eob_outpatient_institutional_ids,
        title: "eob_outpatient_institutional IDs",
        type: 'text',
        description: "eob_outpatient_institutional Resource ID"

      input_order :url, :smart_credentials, :eob_outpatient_institutional_ids

      def resource_type
        'ExplanationOfBenefit'
      end

      def scratch_resources
        scratch[:explanationofbenefit_resources] ||= {}
      end

      def eob_outpatient_institutional_id_list
        return [nil] unless respond_to? :eob_outpatient_institutional_ids
        eob_outpatient_institutional_ids.split(',').map(&:strip)
      end

      run do
        perform_read_test(eob_outpatient_institutional_id_list)
      end
    end
  end
end
