require_relative '../urls'
require_relative '../client_validation_test'

module CarinForBlueButtonTestKit
  class C4BBClientCoverageRequiredSearches < Inferno::Test
    include URLs
    include CarinForBlueButtonTestKit::ClientValidationTest

    id :coverage_required_searches
    title 'Coverage required search parameters'
    description %(
      This test will look through all the requests for to find a Coverage search request with each of the following
      required search parameters:
        * _id
        * patient
    )
    input :access_token

    def required_searches
      [
        '_id',
        'patient'
      ]
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
