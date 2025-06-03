# frozen_string_literal: true

require_relative '../../../read_test'
require 'json'

module CarinForBlueButtonTestKit
  module CARIN4BBV200
    class RelatedPersonReadTest < Inferno::Test
      include CarinForBlueButtonTestKit::ReadTest

      title 'Server returns correct RelatedPerson resource from RelatedPerson read interaction'
      description 'A server SHALL support the RelatedPerson read interaction.'

      id :c4bb_v200_related_person_read_test

      def resource_type
        'RelatedPerson'
      end

      def scratch_resources
        scratch[:relatedperson_resources] ||= {}
      end

      def resource_ids
        return [] unless respond_to? :additional_related_person_ids

        additional_related_person_ids.split(',').map(&:strip)
      end

      run do
        perform_read_test(scratch.dig(:references, 'RelatedPerson'))
      end
    end
  end
end
