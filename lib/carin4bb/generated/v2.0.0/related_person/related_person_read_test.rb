require_relative '../../../read_test'
require 'json'
require_relative '../../../ext/fhir_models'

module CARINForBlueButton
  module CARIN4BBV200
    class RelatedPersonReadTest < Inferno::Test
      include CARINForBlueButton::ReadTest

      title 'Server returns correct RelatedPerson resource from RelatedPerson read interaction'
      description 'A server SHALL support the RelatedPerson read interaction.'

      id :c4bb_v200_related_person_read_test

      input :related_person_ids,
        title: "related_person IDs",
        type: 'text',
        description: "related_person Resource ID"
    
    
      #makes_request :related_person_request

      def resource_type
        'RelatedPerson'
      end

      def scratch_resources
        scratch[:related_person_resources] ||= {}
      end

      def related_person_resource
        #fhir_read(:related_person, related_person_ids)
        file = File.open('lib/carin4bb/ext/examples/related_person_ex_1.json', 'r')
        resource = FHIR::Json.from_json(file.read)
        resource
      end

      run do
        perform_read_test([related_person_resource])
      end
    end
  end
end
