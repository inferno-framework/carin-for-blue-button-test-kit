require_relative '../../../carin_search_test'
require_relative '../../../generator/group_metadata'

module C4BBTestKit
  module CARIN4BBV110
    class EobProfessionalNonClinicianIdentifierSearchTest < Inferno::Test
      include C4BBTestKit::CarinSearchTest

      title 'Server returns valid results for ExplanationOfBenefit search by identifier'
      description %(
A server SHALL support searching by
identifier on the ExplanationOfBenefit resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.


      )

      id :c4bb_v110_eob_professional_non_clinician_identifier_search_test

      input :c4bb_v110_eob_professional_non_clinician_identifier_search_test_param,
        title: 'ExplanationOfBenefit search parameter for identifier
',
        type: 'text',
        description: 'ExplanationOfBenefit search parameter: identifier
'

      def self.properties
        @properties ||= SearchTestProperties.new(
          resource_type: 'ExplanationOfBenefit',
        search_param_names: ['identifier'],
        token_search_params: ['identifier']
        )
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:eob_professional_non_clinician_resources] ||= {}
      end

      run do
        
        run_search_test(c4bb_v110_eob_professional_non_clinician_identifier_search_test_param)
      end
    end
  end
end
