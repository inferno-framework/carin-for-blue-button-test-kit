require_relative '../../../read_test'
require 'json'

module CarinForBlueButtonTestKit
  module CARIN4BBV200
    class PatientReadTest < Inferno::Test
      include CarinForBlueButtonTestKit::ReadTest

      title 'Server returns correct Patient resource from Patient read interaction'
      description 'A server SHALL support the Patient read interaction.'

      id :c4bb_v200_patient_read_test
      
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
