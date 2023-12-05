require_relative '../../../read_test'
require 'json'

module CarinForBlueButtonTestKit
  module CARIN4BBV200
    class RelatedPersonReadTest < Inferno::Test
      include CarinForBlueButtonTestKit::ReadTest

      title 'Server returns correct RelatedPerson resource from RelatedPerson read interaction'
      description 'A server SHALL support the RelatedPerson read interaction.'

      id :c4bb_v200_related_person_read_test
      
      input :related_person_ids,
        title: "related_person IDs",
        type: 'text',
        description: "related_person Resource ID"
      
      input_order :url, :smart_credentials, :related_person_ids

      def resource_type
        'RelatedPerson'
      end

      def scratch_resources
        scratch[:relatedperson_resources] ||= {}
      end

      def related_person_id_list
        return [] unless respond_to? :related_person_ids
        related_person_ids.split(',').map(&:strip)
      end

      run do
        perform_read_test(related_person_id_list)
      end
    end
  end
end
