require_relative '../urls'
require_relative '../client_validation_test'

module CarinForBlueButtonTestKit
  class C4BBClientEOBRequiredSearches < Inferno::Test
    include URLs
    include CarinForBlueButtonTestKit::ClientValidationTest

    id :eob_required_searches
    title 'Explanation of Benefit required search parameters'
    description %(
      This test will look through all the requests for to find a Explanation of Benefit search request with each of the
      following required search parameters:
        * _id
        * patient
        * identifier
        * _lastUpdated
        * service-date
        * service-start-date
        * billable-period-start
        * type
        * _include:
          * ExplanationOfBenefit:patient
          * ExplanationOfBenefit:provider
          * ExplanationOfBenefit:care-team
          * ExplanationOfBenefit:coverage
          * ExplanationOfBenefit:insurer
          * ExplanationOfBenefit:payee
          * ExplanationOfBenefit:*
    )
    input :access_token

    def required_searches
      [
        '_id',
        'patient',
        'identifier',
        '_lastUpdated',
        'service-date',
        'service-start-date',
        'billable-period-start',
        'type',
        '_include=ExplanationOfBenefit:patient',
        '_include=ExplanationOfBenefit:provider',
        '_include=ExplanationOfBenefit:care-team',
        '_include=ExplanationOfBenefit:coverage',
        '_include=ExplanationOfBenefit:insurer',
        '_include=ExplanationOfBenefit:payee',
        '_include=ExplanationOfBenefit:*'
      ]
    end

    run do
      search_params = resource_previous_search_params(:ExplanationOfBenefitSearch)
      skip_if search_params.nil?, 'No search requests made for Explanation of Benefit resource'
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
