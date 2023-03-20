require_relative '../../../read_test'
require 'json'
require_relative '../../../ext/fhir_models'

module CARINForBlueButton
  module CARIN4BBV120
    class PatientReadTest < Inferno::Test
      include CARINForBlueButton::ReadTest

      title 'Server returns correct Patient resource from Patient read interaction'
      description 'A server SHALL support the Patient read interaction.'

      id :c4bb_v120_patient_read_test

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

      #def patient_resource
      #  fhir_read(:patient, patient_ids, name: :patient_request)
      #  #file = File.open('lib/carin4bb/ext/examples/patient_ex_1.json', 'r')
      #  #resource = FHIR::Json.from_json(file.read)
      #  resource
      #end

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
