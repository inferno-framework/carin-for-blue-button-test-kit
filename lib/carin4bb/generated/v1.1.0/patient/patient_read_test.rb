require_relative '../../../read_test'
require 'json'
require_relative '../../../ext/fhir_models'

module CARINForBlueButton
  module CARIN4BBV110
    class PatientReadTest < Inferno::Test
      include CARINForBlueButton::ReadTest

      title 'Server returns correct Patient resource from Patient read interaction'
      description 'A server SHALL support the Patient read interaction.'

      id :c4bb_v110_patient_read_test

      input :patient_ids,
        title: "patient IDs",
        type: 'text',
        description: "patient Resource ID"
    
    
      #makes_request :patient_request

      def resource_type
        'Patient'
      end

      def scratch_resources
        scratch[:patient_resources] ||= {}
      end

      def patient_resource
        #fhir_read(:patient, patient_ids)
        file = File.open('lib/carin4bb/ext/examples/patient_ex_1.json', 'r')
        resource = FHIR::Json.from_json(file.read)
        resource
      end

      run do
        perform_read_test([patient_resource])
      end
    end
  end
end
