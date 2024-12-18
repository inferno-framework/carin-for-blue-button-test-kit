require_relative '../urls'
require_relative '../client_validation_test'

module CarinForBlueButtonTestKit
  class C4BBClientOrganizationRequiredSearches < Inferno::Test
    include URLs
    include CarinForBlueButtonTestKit::ClientValidationTest

    id :organization_required_searches
    title 'Organization required search parameters'
    description %(
      This test will look through all the requests to find a Organization search request with each of the following
      required search parameters specified for the Organization resource in the
      [CARIN for Blue Button](https://hl7.org/fhir/us/carin-bb/STU2/CapabilityStatement-c4bb.html#organization)
      and [US Core Client](https://www.hl7.org/fhir/us/core/STU3.1.1/CapabilityStatement-us-core-client.html#organization)
      Capability Statements:
        * _id
        * name
        * address
    )

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@14'

    def required_searches
      [
        '_id',
        'name',
        'address'
      ]
    end

    run do
      search_params = resource_previous_search_params(:OrganizationSearch)
      skip_if search_params.nil?, 'No search requests made for Organization resource'

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
