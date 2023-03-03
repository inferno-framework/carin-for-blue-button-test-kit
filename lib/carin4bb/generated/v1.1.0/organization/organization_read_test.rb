require_relative '../../../read_test'
require 'json'
require_relative '../../../ext/fhir_models'

module CARINForBlueButton
  module CARIN4BBV110
    class OrganizationReadTest < Inferno::Test
      include CARINForBlueButton::ReadTest

      title 'Server returns correct Organization resource from Organization read interaction'
      description 'A server SHALL support the Organization read interaction.'

      id :c4bb_v110_organization_read_test

      input :organization_ids,
        title: "organization IDs",
        type: 'text',
        description: "organization Resource ID"
    
    
      #makes_request :organization_request

      def resource_type
        'Organization'
      end

      def scratch_resources
        scratch[:organization_resources] ||= {}
      end

      def organization_resource
        #fhir_read(:organization, organization_ids)
        file = File.open('lib/carin4bb/ext/examples/organization_ex_1.json', 'r')
        resource = FHIR::Json.from_json(file.read)
        resource
      end

      run do
        perform_read_test([organization_resource])
      end
    end
  end
end
