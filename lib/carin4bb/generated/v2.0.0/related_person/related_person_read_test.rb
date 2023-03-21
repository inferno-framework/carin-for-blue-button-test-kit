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

      def resource_type
        'RelatedPerson'
      end

      def scratch_resources
        scratch[:related_person_resources] ||= {}
      end

      def related_person_id_list
        return [nil] unless respond_to? :related_person_ids
        related_person_ids.split(',').map(&:strip)
      end

      run do
        perform_read_test(related_person_id_list)
      end
    end
  end
end
