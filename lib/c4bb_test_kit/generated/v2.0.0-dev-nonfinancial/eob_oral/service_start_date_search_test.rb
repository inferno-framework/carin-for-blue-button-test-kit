require_relative '../../../carin_search_test'
require_relative '../../../generator/group_metadata'

module C4BBTestKit
  module CARIN4BBV200DEVNONFINANCIAL
    class EobOralServiceStartDateSearchTest < Inferno::Test
      include C4BBTestKit::CarinSearchTest

      title 'Server returns valid results for ExplanationOfBenefit search by service-start-date'
      description %(
A server SHALL support searching by
service-start-date on the ExplanationOfBenefit resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.


      )

      id :c4bb_v200devnonfinancial_eob_oral_service_start_date_search_test

      input :c4bb_v200devnonfinancial_eob_oral_service_start_date_search_test_param,
        title: 'ExplanationOfBenefit search parameter for service-start-date
',
        type: 'text',
        description: 'ExplanationOfBenefit search parameter: service-start-date
'

      def self.properties
        @properties ||= SearchTestProperties.new(
          resource_type: 'ExplanationOfBenefit',
        search_param_names: ['service-start-date']
        )
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:eob_oral_resources] ||= {}
      end

      run do
        
        run_search_test(c4bb_v200devnonfinancial_eob_oral_service_start_date_search_test_param)
      end
    end
  end
end
