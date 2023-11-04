require_relative '../../../carin_search_test'
require_relative '../../../generator/group_metadata'

module CarinForBlueButtonTestKit
  module CARIN4BBV200DEVNONFINANCIAL
    class RelatedPersonIdSearchTest < Inferno::Test
      include CarinForBlueButtonTestKit::CarinSearchTest

      title 'Server returns valid results for RelatedPerson search by _id'
      description %(
A server SHALL support searching by
_id on the RelatedPerson resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

Because this is the first search of the sequence, resources in the
response will be used for subsequent tests.

Additionally, this test will check that GET and POST search methods
return the same number of results. Search by POST is required by the
FHIR R4 specification, and these tests interpret search by GET as a
requirement of CARIN IG for Blue Button® v2.0.0-dev-nonfinancial.


      )

      id :c4bb_v200devnonfinancial_related_person__id_search_test

      input :related_person_ids,
        title: 'related_person IDs',
        type: 'text',
        description: 'Comma separated list of related_person IDs that in sum
                          contain all MUST SUPPORT elements'

      def self.properties
        @properties ||= SearchTestProperties.new(
          first_search: true,
        resource_type: 'RelatedPerson',
        search_param_names: ['_id'],
        test_post_search: true
        )
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:related_person_resources] ||= {}
      end
      
      def related_person_ids_string_formatter
        return [nil] unless respond_to? :related_person_ids
        related_person_ids.split(',').map(&:strip).join(',')
      end
      
      run do
        
        run_search_test(related_person_ids_string_formatter)
      end
    end
  end
end
