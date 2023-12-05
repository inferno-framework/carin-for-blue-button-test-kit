require_relative '../../../read_test'
require 'json'

module CarinForBlueButtonTestKit
  module CARIN4BBV110
    class EobProfessionalNonClinicianReadTest < Inferno::Test
      include CarinForBlueButtonTestKit::ReadTest

      title 'Server returns correct ExplanationOfBenefit resource from ExplanationOfBenefit read interaction'
      description 'A server SHALL support the ExplanationOfBenefit read interaction.'

      id :c4bb_v110_eob_professional_non_clinician_read_test

      input :eob_professional_non_clinician_ids,
        title: "eob_professional_non_clinician IDs",
        type: 'text',
        description: "eob_professional_non_clinician Resource ID"

      input_order :url, :smart_credentials, :eob_professional_non_clinician_ids

      def resource_type
        'ExplanationOfBenefit'
      end

      def scratch_resources
        scratch[:explanationofbenefit_resources] ||= {}
      end

      def eob_professional_non_clinician_id_list
        return [nil] unless respond_to? :eob_professional_non_clinician_ids
        eob_professional_non_clinician_ids.split(',').map(&:strip)
      end

      run do
        perform_read_test(eob_professional_non_clinician_id_list)
      end
    end
  end
end
