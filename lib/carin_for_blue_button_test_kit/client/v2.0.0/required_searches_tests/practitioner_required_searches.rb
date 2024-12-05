require_relative '../urls'
require_relative '../client_validation_test'

module CarinForBlueButtonTestKit
  class C4BBClientPractitionerRequiredSearches < Inferno::Test
    include URLs
    include CarinForBlueButtonTestKit::ClientValidationTest

    id :practitioner_required_searches
    title 'Practitioner required search parameters'
    description %(
      This test will look through all the requests to find a Practitioner search request with each of the following
      required search parameters specified for the Practitioner resource in the
      [CARIN for Blue Button](https://hl7.org/fhir/us/carin-bb/STU2/CapabilityStatement-c4bb.html#practitioner)
      and [US Core Client](https://www.hl7.org/fhir/us/core/STU3.1.1/CapabilityStatement-us-core-client.html#practitioner)
      Capability Statements:
        * _id
        * name
        * identifier
    )
    input :access_token

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@14',
                          '170.315(g)(31)_hti-2-proposal@32'

    def required_searches
      [
        '_id',
        'name',
        'identifier'
      ]
    end

    run do
      search_params = resource_previous_search_params(:PractitionerSearch)
      skip_if search_params.nil?, 'No search requests made for Practitioner resource'

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
