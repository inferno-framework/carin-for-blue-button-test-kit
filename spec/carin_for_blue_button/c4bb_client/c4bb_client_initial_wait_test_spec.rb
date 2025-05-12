require_relative '../../../lib/carin_for_blue_button_test_kit/client/v2.0.0/initial_wait_test'
require_relative '../../request_helper'

RSpec.describe CarinForBlueButtonTestKit::C4BBClientInitialWaitTest do
  include Rack::Test::Methods
  include RequestHelpers

  let(:suite) { Inferno::Repositories::TestSuites.new.find('c4bb_v200_client') }
  let(:test) { Inferno::Repositories::Tests.new.find('c4bb_v200_initial_wait_test') }
  let(:session_data_repo) { Inferno::Repositories::SessionData.new }
  let(:results_repo) { Inferno::Repositories::Results.new }
  let(:test_session) { repo_create(:test_session, test_suite_id: 'c4bb_v200_client') }

  let(:base_url) { "#{Inferno::Application['base_url']}/custom/c4bb_v200_client/fhir" }
  let(:fhir_server) { ENV.fetch('FHIR_REFERENCE_SERVER') }
  let(:patient_endpoint) { '/Patient?_id=888' }
  let(:eob_include_search_endpoint) do
    '/ExplanationOfBenefit?_include=ExplanationOfBenefit:patient&_include=' \
      'ExplanationOfBenefit:provider&_include=ExplanationOfBenefit:care-team&_include=ExplanationOfBenefit' \
      ':coverage&_include=ExplanationOfBenefit:payee&patient=888'
  end

  let(:patient_api_request) { "#{base_url}#{patient_endpoint}" }
  let(:eob_include_search) { "#{base_url}#{eob_include_search_endpoint}" }
  let(:invalid_patient_api_request) { "#{base_url}/Patient?death-date=2024-10-21" }
  let(:server_patient_api_request) { "#{fhir_server}#{patient_endpoint}" }
  let(:server_eob_include_search) { "#{fhir_server}#{eob_include_search_endpoint}" }

  let(:reference_server_token) { 'SAMPLE_TOKEN' }
  let(:client_id) { 'SAMPLE_CLIENT_ID' }
  let(:bearer_token) { SMARTAppLaunch::MockSMARTServer.client_id_to_token(client_id, 5) }

  let(:resume_claims_data_url) do
    "#{Inferno::Application['base_url']}/custom/c4bb_v200_client/resume_claims_data?test_run_identifier=#{client_id}"
  end

  let(:c4bb_eob_include_bundle) do
    JSON.parse(File.read(File.join(
                           __dir__, '..', '..', 'fixtures', 'c4bb_eob_include_bundle.json'
                         )))
  end

  let(:c4bb_patient_resource) do
    JSON.parse(File.read(File.join(
                           __dir__, '..', '..', 'fixtures', 'c4bb_patient_example.json'
                         )))
  end

  let(:c4bb_patient_search_bundle) do
    bundle = FHIR::Bundle.new(type: 'searchset')
    bundle.link.append(
      {
        relation: 'self',
        url: patient_api_request
      }
    )
    bundle.entry.append(FHIR::Bundle::Entry.new(
                          fullUrl: server_patient_api_request,
                          resource: FHIR.from_contents(c4bb_patient_resource.to_json)
                        ))
    bundle
  end

  def run(runnable, inputs = {})
    test_run_params = { test_session_id: test_session.id }.merge(runnable.reference_hash)
    test_run = Inferno::Repositories::TestRuns.new.create(test_run_params)

    inputs.each do |name, value|
      session_data_repo.save(
        test_session_id: test_session.id,
        name:,
        value:,
        type: runnable.config.input_type(name)
      )
    end
    Inferno::TestRunner.new(test_session:, test_run:).run(runnable)
  end

  it 'Passes and responds 200 if valid Patient API request sent to the provided URL and Bearer token is correct' do
    allow(test).to receive_messages(suite:, parent: suite)

    patient_fhir_api_request = stub_request(:get, server_patient_api_request)
      .with(
        headers: { 'Authorization' => "Bearer #{reference_server_token}" }
      )
      .to_return(status: 200, body: c4bb_patient_search_bundle.to_json)

    result = run(test, client_id:)

    expect(result.result).to eq('wait')

    header 'Authorization', "Bearer #{bearer_token}"
    get(patient_api_request)

    expect(last_response).to be_ok
    response_body = JSON.parse(last_response.body)

    expect(response_body['resourceType']).to eq('Bundle')
    expect(response_body['entry'].first['resource']['resourceType']).to eq('Patient')
    expect(last_request.env['inferno.tags']).to include('carin_resource_api', 'Patient', '_id')
    get(resume_claims_data_url)
    result = results_repo.find(result.id)
    expect(result.result).to eq('pass')
    expect(patient_fhir_api_request).to have_been_made
  end

  it 'Passes and responds 200 if valid EOB include search request sent to the provided URL' do
    allow(test).to receive_messages(suite:, parent: suite)

    eob_fhir_include_search = stub_request(:get, server_eob_include_search)
      .with(
        headers: { 'Authorization' => "Bearer #{reference_server_token}" }
      )
      .to_return(status: 200, body: c4bb_eob_include_bundle.to_json)

    result = run(test, client_id:)

    expect(result.result).to eq('wait')

    header 'Authorization', "Bearer #{bearer_token}"
    get(eob_include_search)

    expect(last_response).to be_ok
    response_body = JSON.parse(last_response.body)

    expect(response_body['resourceType']).to eq('Bundle')
    expect(response_body['entry'].length).to eq 10
    expect(response_body['entry'].first['resource']['resourceType']).to eq('ExplanationOfBenefit')
    expect(last_request.env['inferno.tags']).to include('carin_resource_api',
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
                                                        '_include=ExplanationOfBenefit:payee')
    get(resume_claims_data_url)
    result = results_repo.find(result.id)
    expect(result.result).to eq('pass')
    expect(eob_fhir_include_search).to have_been_made
  end

  it 'Responds 500 if Bearer token is incorrect' do
    allow(test).to receive_messages(suite:, parent: suite)

    result = run(test, client_id:)

    header 'Authorization', 'Bearer WRONG_TOKEN'
    get(patient_api_request)

    expect(last_response).to be_server_error
    expect(last_response.body).to match(/find test run with identifier/)

    result = results_repo.find(result.id)
    expect(result.result).to eq('wait')

    get(resume_claims_data_url)
    result = results_repo.find(result.id)
    expect(result.result).to eq('pass')
  end

  it 'Responds 500 and OperationOutcome if search is not supported' do
    allow(test).to receive_messages(suite:, parent: suite)

    patient_fhir_api_request = stub_request(:get, server_patient_api_request)
      .with(
        headers: { 'Authorization' => "Bearer #{reference_server_token}" }
      )
      .to_return(status: 200, body: c4bb_patient_search_bundle.to_json)

    result = run(test, client_id:)

    header 'Authorization', "Bearer #{bearer_token}"
    get(invalid_patient_api_request)

    expect(last_response.status).to eq(403)

    response_body = JSON.parse(last_response.body)
    expect(response_body['resourceType']).to eq('Bundle')
    expect(response_body['entry'].first['resource']['resourceType']).to eq('OperationOutcome')

    result = results_repo.find(result.id)
    expect(result.result).to eq('wait')

    get(resume_claims_data_url)
    result = results_repo.find(result.id)
    expect(result.result).to eq('pass')
    expect(patient_fhir_api_request).to have_been_made
  end

  it 'Responds server status and response body even when not 200 response' do
    allow(test).to receive_messages(suite:, parent: suite)

    patient_fhir_api_request = stub_request(:get, server_patient_api_request)
      .with(
        headers: { 'Authorization' => "Bearer #{reference_server_token}" }
      )
      .to_return(status: 404, body: c4bb_patient_search_bundle.to_json)

    result = run(test, client_id:)

    expect(result.result).to eq('wait')

    header 'Authorization', "Bearer #{bearer_token}"
    get(patient_api_request)

    expect(last_response.status).to eq(404)

    response_body = JSON.parse(last_response.body)

    expect(response_body['resourceType']).to eq('Bundle')
    expect(response_body['entry'].first['resource']['resourceType']).to eq('Patient')

    get(resume_claims_data_url)
    result = results_repo.find(result.id)
    expect(result.result).to eq('pass')
    expect(patient_fhir_api_request).to have_been_made
  end
end
