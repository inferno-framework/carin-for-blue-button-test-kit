require_relative '../../../read_test'
require 'json'

module CarinForBlueButtonTestKit
  module CARIN4BBV110
    class PatientReadTest < Inferno::Test
      include CarinForBlueButtonTestKit::ReadTest

      title 'Server returns correct Patient resource from Patient read interaction'
      description 'A server SHALL support the Patient read interaction.'

      id :c4bb_v110_patient_read_test
      
      input :additional_patient_ids,
        title: "Additional patient IDs",
        type: 'text',
        description: "Comma separated list of patient IDs that in sum
                          contain all MUST SUPPORT elements. This is optional, but must be provided if executing only the Patient test group.",
        optional: true
      
      def resource_type
        'Patient'
      end

      def scratch_resources
        scratch[:patient_resources] ||= {}
      end

      def resource_ids
        return [] unless respond_to? :additional_patient_ids
        additional_patient_ids.split(',').map(&:strip)
      end

      run do
        perform_read_test(all_scratch_resources)
      end
    end
  end
end
