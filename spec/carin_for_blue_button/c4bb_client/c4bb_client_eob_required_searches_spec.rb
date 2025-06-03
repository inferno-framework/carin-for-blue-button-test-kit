# frozen_string_literal: true

require_relative '../../../lib/carin_for_blue_button_test_kit/client/v2.0.0/claim_data_request_tests/' \
                 'patient_claims_data_request_test'

RSpec.describe CarinForBlueButtonTestKit::C4BBClientEOBRequiredSearches do
  let(:suite_id) { 'c4bb_v200_client' }
  let(:suite) { Inferno::Repositories::TestSuites.new.find(suite_id) }
  let(:test) { Inferno::Repositories::Tests.new.find('eob_required_searches') }
  let(:results_repo) { Inferno::Repositories::Results.new }
  let(:test_session) { repo_create(:test_session, test_suite_id: suite_id) }
  let(:result) { repo_create(:result, test_session_id: test_session.id) }

  let(:c4bb_eob_include_bundle) do
    JSON.parse(File.read(File.join(
                           __dir__, '..', '..', 'fixtures', 'c4bb_eob_include_bundle.json'
                         )))
  end

  let(:c4bb_inpatient_eob_resource) do
    JSON.parse(File.read(File.join(
                           __dir__, '..', '..', 'fixtures', 'c4bb_eob_inpatient_example.json'
                         )))
  end
  let(:c4bb_eob_search_bundle) do
    bundle = FHIR::Bundle.new(type: 'searchset')
    bundle.entry.append(FHIR::Bundle::Entry.new(
                          fullUrl: eob_id_search_endpoint,
                          resource: FHIR.from_contents(c4bb_inpatient_eob_resource.to_json)
                        ))
    JSON.parse(bundle.to_json)
  end

  let(:base_url) { "#{Inferno::Application['base_url']}/custom/c4bb_v200_client/fhir" }
  let(:eob_include_search_endpoint) do
    '/ExplanationOfBenefit?_include=ExplanationOfBenefit:patient&_include=' \
      'ExplanationOfBenefit:provider&_include=ExplanationOfBenefit:care-team&_include=ExplanationOfBenefit' \
      ':coverage&_include=ExplanationOfBenefit:payee&_include=ExplanationOfBenefit:insurer&patient=888'
  end
  let(:eob_include_all_search_endpoint) do
    '/ExplanationOfBenefit?_include=ExplanationOfBenefit:*&patient=888'
  end
  let(:eob_required_searches_endpoint) do
    '/ExplanationOfBenefit?identifier=AW123412341234123412341234123412&service-date=2019-11-02&' \
      'service-start-date=2019-11-02&billable-period-start=2019-01-01&type=institutional'
  end
  let(:eob_last_updated_search_endpoint) do
    '/ExplanationOfBenefit?_lastUpdated=2024-11-06'
  end
  let(:eob_id_search_endpoint) do
    '/ExplanationOfBenefit?_id=c4bb-EOBInpatient'
  end

  let(:eob_include_search) { "#{base_url}#{eob_include_search_endpoint}" }
  let(:eob_include_all_search) { "#{base_url}#{eob_include_all_search_endpoint}" }
  let(:eob_required_search_params_search) { "#{base_url}#{eob_required_searches_endpoint}" }
  let(:eob_last_updated_search) { "#{base_url}#{eob_last_updated_search_endpoint}" }
  let(:eob_id_search) { "#{base_url}#{eob_id_search_endpoint}" }
  let(:eob_required_searches) do
    [{ eob_include_search => [eob_include_search_tags, c4bb_eob_include_bundle] },
     { eob_include_all_search => [eob_include_all_search_tags, c4bb_eob_include_bundle] },
     { eob_required_search_params_search => [eob_required_search_tags, c4bb_eob_search_bundle] },
     { eob_last_updated_search => [eob_last_upated_search_tags, c4bb_eob_search_bundle] },
     { eob_id_search => [eob_id_search_tags, c4bb_eob_search_bundle] }]
  end
  let(:eob_include_search_tags) do
    ['resource_api',
     'ExplanationOfBenefitSearch',
     'ExplanationOfBenefit_Inpatient_Institutional',
     'ExplanationOfBenefit_Outpatient_Institutional',
     'ExplanationOfBenefit_Oral',
     'ExplanationOfBenefit_Pharmacy',
     'ExplanationOfBenefit_Professional_NonClinician',
     'Coverage',
     'Organization',
     'Practitioner',
     'Patient',
     'RelatedPerson',
     'patient',
     '_include=ExplanationOfBenefit:patient',
     '_include=ExplanationOfBenefit:provider',
     '_include=ExplanationOfBenefit:care-team',
     '_include=ExplanationOfBenefit:coverage',
     '_include=ExplanationOfBenefit:insurer',
     '_include=ExplanationOfBenefit:payee']
  end

  let(:eob_include_all_search_tags) do
    ['resource_api',
     'ExplanationOfBenefitSearch',
     'ExplanationOfBenefit_Inpatient_Institutional',
     'ExplanationOfBenefit_Outpatient_Institutional',
     'ExplanationOfBenefit_Oral',
     'ExplanationOfBenefit_Pharmacy',
     'ExplanationOfBenefit_Professional_NonClinician',
     'Coverage',
     'Organization',
     'Practitioner',
     'Patient',
     'RelatedPerson',
     'patient',
     '_include=ExplanationOfBenefit:*']
  end

  let(:eob_required_search_tags) do
    %w[
      resource_api
      ExplanationOfBenefitSearch
      ExplanationOfBenefit_Inpatient_Institutional
      identifier
      service-date
      service-start-date
      billable-period-start
      type
    ]
  end

  let(:eob_last_upated_search_tags) do
    %w[
      resource_api
      ExplanationOfBenefitSearch
      ExplanationOfBenefit_Inpatient_Institutional
      _lastUpdated
    ]
  end

  let(:eob_id_search_tags) do
    %w[
      resource_api
      ExplanationOfBenefitSearch
      ExplanationOfBenefit_Inpatient_Institutional
      _id
    ]
  end

  let(:bearer_token) { JWT.encode({ inferno_client_id: 'SAMPLE_CLIENT_ID' }, nil, 'none') }

  def make_all_eob_search_requests(eob_searches)
    eob_searches.each do |search|
      search.each do |url, request|
        create_fhir_api_request(url:, body: request.last, tags: request.first)
      end
    end
  end

  def create_fhir_api_request(url: nil, body: nil, status: 200,
                              tags: nil, headers: nil)
    headers ||= [
      {
        type: 'request',
        name: 'Authorization',
        value: "Bearer #{bearer_token}"
      }
    ]
    repo_create(
      :request,
      name: 'fhir_api_request',
      direction: 'outgoing',
      url:,
      result:,
      response_body: body.is_a?(Hash) ? body.to_json : body,
      test_session_id: test_session.id,
      status:,
      headers:,
      tags:
    )
  end

  it 'passes if successful FHIR search requests for all required searches for EOB was made' do
    allow(test).to receive(:suite).and_return(suite)

    make_all_eob_search_requests(eob_required_searches)

    result = run(test)
    expect(result.result).to eq('pass')
  end

  it 'skips if no EOB search requests were made' do
    allow(test).to receive(:suite).and_return(suite)

    result = run(test)
    expect(result.result).to eq('skip')
    expect(result.result_message).to eq('No search requests made for Explanation of Benefit resource')
  end

  it 'fails if any required EOB search request was not made' do
    allow(test).to receive(:suite).and_return(suite)

    eob_required_searches.pop
    make_all_eob_search_requests(eob_required_searches)

    result = run(test)
    expect(result.result).to eq('fail')
    expect(result.result_message).to match(/_id/)
  end
end
