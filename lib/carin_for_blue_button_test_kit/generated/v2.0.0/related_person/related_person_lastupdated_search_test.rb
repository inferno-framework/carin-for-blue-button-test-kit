require_relative '../../../carin_search_test'
require_relative '../../../generator/group_metadata'

module CarinForBlueButtonTestKit
  module CARIN4BBV200
    class RelatedPersonLastupdatedSearchTest < Inferno::Test
      include CarinForBlueButtonTestKit::CarinSearchTest

      title 'Server returns valid results for RelatedPerson search by _lastUpdated'
      description %(
A server SHOULD support searching by
_lastUpdated on the RelatedPerson resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.
      )

      id :c4bb_v200_related_person__lastUpdated_search_test

      input :c4bb_v200_related_person__lastUpdated_search_test_param,
        title: 'RelatedPerson search parameter for _lastUpdated',
        type: 'text',
        description: 'RelatedPerson search parameter: _lastUpdated',
        optional: true

      def self.properties
        @properties ||= SearchTestProperties.new(
          resource_type: 'RelatedPerson',
        search_param_names: ['_lastUpdated']
        )
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:related_person_resources] ||= {}
      end

      run do
        skip '_lastUpdated optional and not provided' unless c4bb_v200_related_person__lastUpdated_search_test_param.present?
        run_search_test(c4bb_v200_related_person__lastUpdated_search_test_param)
      end
    end
  end
end
