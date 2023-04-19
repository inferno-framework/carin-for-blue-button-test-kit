require_relative '../../../read_test'
require 'json'
require_relative '../../../ext/fhir_models'

module CarinForBlueButtonTestKit
  module CARIN4BBV200
    class PractitionerReadTest < Inferno::Test
      include CarinForBlueButtonTestKit::ReadTest

      title 'Server returns correct Practitioner resource from Practitioner read interaction'
      description 'A server SHALL support the Practitioner read interaction.'

      id :c4bb_v200_practitioner_read_test

      input :practitioner_ids,
        title: "practitioner IDs",
        type: 'text',
        description: "practitioner Resource ID"

      input_order :url, :smart_credentials, :practitioner_ids
      
      def resource_type
        'Practitioner'
      end

      def scratch_resources
        scratch[:practitioner_resources] ||= {}
      end

      def practitioner_id_list
        return [nil] unless respond_to? :practitioner_ids
        practitioner_ids.split(',').map(&:strip)
      end

      run do
        perform_read_test(practitioner_id_list)
      end
    end
  end
end
