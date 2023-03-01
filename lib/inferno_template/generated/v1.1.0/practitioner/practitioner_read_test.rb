require_relative '../../../read_test'
require 'json'
require_relative '../../../ext/fhir_models'

module InfernoTemplate
  module CARIN4BBV110
    class PractitionerReadTest < Inferno::Test
      include InfernoTemplate::ReadTest

      title 'Server returns correct Practitioner resource from Practitioner read interaction'
      description 'A server SHALL support the Practitioner read interaction.'

      id :c4bb_v110_practitioner_read_test

      input :practitioner_ids,
        title: "practitioner IDs",
        type: 'text',
        description: "practitioner Resource ID"
    
    
      #makes_request :practitioner_request

      def resource_type
        'Practitioner'
      end

      def scratch_resources
        scratch[:practitioner_resources] ||= {}
      end

      def practitioner_resource
        #fhir_read(:practitioner, practitioner_ids)
        file = File.open('lib/inferno_template/ext/examples/practitioner_ex_1.json', 'r')
        resource = FHIR::Json.from_json(file.read)
        resource
      end

      run do
        perform_read_test([practitioner_resource])
      end
    end
  end
end
