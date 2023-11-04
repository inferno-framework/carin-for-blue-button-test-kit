require_relative '../../../read_test'
require 'json'

module CarinForBlueButtonTestKit
  module CARIN4BBV200DEVNONFINANCIAL
    class PatientReadTest < Inferno::Test
      include CarinForBlueButtonTestKit::ReadTest

      title 'Server returns correct Patient resource from Patient read interaction'
      description 'A server SHALL support the Patient read interaction.'

      id :c4bb_v200devnonfinancial_patient_read_test

      input :patient_ids,
        title: "patient IDs",
        type: 'text',
        description: "Comma separated list of patient IDs that in sum contain all MUST SUPPORT elements"

      input_order :url, :smart_credentials, :patient_ids

      def resource_type
        'Patient'
      end

      def scratch_resources
        scratch[:patient_resources] ||= {}
      end

      def patient_id_list
        return [nil] unless respond_to? :patient_ids
        patient_ids.split(',').map(&:strip)
      end

      run do
        perform_read_test(patient_id_list)
      end
    end
  end
end
