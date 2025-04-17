require_relative '../urls'
require_relative '../client_validation_test'

module CarinForBlueButtonTestKit
  class C4BBClientCoverageRequiredSearches < Inferno::Test
    include URLs
    include CarinForBlueButtonTestKit::ClientValidationTest

    id :coverage_required_searches
    title 'Coverage required search parameters'
    description %(
      This test will look through all the requests to find a Coverage search request with each of the following
      required search parameters specified for the Coverage resource in the
      [CARIN for Blue Button](https://hl7.org/fhir/us/carin-bb/STU2/CapabilityStatement-c4bb.html#coverage)
      and [US Core Client](https://www.hl7.org/fhir/us/core/STU3.1.1/CapabilityStatement-us-core-client.html)
      Capability Statements:
        * _id
        * patient
    )

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@14'

    def required_searches
      [
        '_id',
        'patient'
      ]
    end

    def suite_id # allow overriding without extension - used by resource_previous_search_params logic
      return config.options[:suite_id] if config.options[:suite_id].present?

      C4BBV200ClientSuite.id
    end

    run do
      search_params = resource_previous_search_params(:CoverageSearch)
      skip_if search_params.nil?, 'No search requests made for Coverage resource'

      missing_params = []
      required_searches.each do |search_param|
        missing_params.append(search_param) unless search_params.include?(search_param)
      end
      assert(missing_params.empty?, %(
        Did not find any requests made with the following required search parameters:
        #{missing_params.join(', ')}
      ))
    end
  end
end
