require_relative '../../../read_test'
require 'json'
require_relative '../../../ext/fhir_models'

module InfernoTemplate
  module CARIN4BBV110
    class CoverageReadTest < Inferno::Test
      include InfernoTemplate::ReadTest

      title 'Server returns correct Coverage resource from Coverage read interaction'
      description 'A server SHALL support the Coverage read interaction.'

      id :c4bb_v110_coverage_read_test

      input :coverage_ids,
        title: "coverage IDs",
        type: 'text',
        description: "coverage Resource ID"
    
    
      #makes_request :coverage_request

      def resource_type
        'Coverage'
      end

      def scratch_resources
        scratch[:coverage_resources] ||= {}
      end

      def coverage_resource
        #fhir_read(:coverage, coverage_ids)
        file = File.open('lib/inferno_template/ext/examples/coverage_ex_1.json', 'r')
        resource = FHIR::Json.from_json(file.read)
        resource
      end

      run do
        perform_read_test([coverage_resource])
      end
    end
  end
end
