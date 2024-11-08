require_relative '../urls'
require_relative '../client_validation_test'

module CarinForBlueButtonTestKit
  class C4BBClientOrganizationRequiredSearches < Inferno::Test
    include URLs
    include CarinForBlueButtonTestKit::ClientValidationTest

    id :organization_required_searches
    title 'Organization required search parameters'
    description %(
      This test will look through all the requests for to find a Organization search request with each of the following
      required search parameters:
        * _id
    )
    input :access_token

    def required_searches
      [
        '_id'
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
