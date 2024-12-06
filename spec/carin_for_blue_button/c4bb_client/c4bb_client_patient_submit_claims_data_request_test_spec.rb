require_relative '../../../lib/carin_for_blue_button_test_kit/client/v2.0.0/claim_data_request_tests/' \
                 'patient_claims_data_request_test'

RSpec.describe CarinForBlueButtonTestKit::C4BBClientPatientSubmitClaimsDataRequestTest do
  let(:suite) { Inferno::Repositories::TestSuites.new.find('c4bb_v200_client') }
  let(:test) { Inferno::Repositories::Tests.new.find('patient_claims_data_request_test') }
  let(:session_data_repo) { Inferno::Repositories::SessionData.new }
  let(:results_repo) { Inferno::Repositories::Results.new }
  let(:test_session) { repo_create(:test_session, test_suite_id: 'c4bb_v200_client') }
  let(:result) { repo_create(:result, test_session_id: test_session.id) }

  let(:c4bb_patient_resource) do
    c4bb_patient = JSON.parse(File.read(File.join(
                                          __dir__, '..', '..', 'fixtures', 'c4bb_patient_example.json'
                                        )))
    c4bb_patient['id'] = '888'
    c4bb_patient
  end

  let(:c4bb_eob_include_bundle) do
    JSON.parse(File.read(File.join(
                           __dir__, '..', '..', 'fixtures', 'c4bb_eob_include_bundle.json'
                         )))
  end

  let(:c4bb_patient_search_bundle) do
    bundle = FHIR::Bundle.new(type: 'searchset')
    bundle.entry.append(FHIR::Bundle::Entry.new(
                          fullUrl: patient_api_request,
                          resource: FHIR.from_contents(c4bb_patient_resource.to_json)
                        ))
    bundle
  end

  let(:base_url) { "#{Inferno::Application['base_url']}/custom/c4bb_v200_client/fhir" }
  let(:patient_endpoint) { '/Patient?_id=888' }
  let(:eob_include_search_endpoint) do
    '/ExplanationOfBenefit?_include=ExplanationOfBenefit:patient&_include=' \
      'ExplanationOfBenefit:provider&_include=ExplanationOfBenefit:care-team&_include=ExplanationOfBenefit' \
      ':coverage&_include=ExplanationOfBenefit:payee&patient=888'
  end
  let(:patient_api_request) { "#{base_url}#{patient_endpoint}" }
  let(:eob_include_search) { "#{base_url}#{eob_include_search_endpoint}" }
  let(:eob_include_search_tags) do
    ['carin_resource_api',
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
     '_include=ExplanationOfBenefit:payee']
  end

  let(:access_token) { 'SAMPLE_TOKEN' }

  def create_fhir_api_request(url: patient_api_request, body: nil, status: 200,
                              tags: ['carin_resource_api', 'Patient', '_id'], headers: nil)
    headers ||= [
      {
        type: 'request',
        name: 'Authorization',
        value: "Bearer #{access_token}"
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

  def run(runnable, inputs = {})
    test_run_params = { test_session_id: test_session.id }.merge(runnable.reference_hash)
    test_run = Inferno::Repositories::TestRuns.new.create(test_run_params)
    inputs.each do |name, value|
      session_data_repo.save(
        test_session_id: test_session.id,
        name:,
        value:,
        type: runnable.config.input_type(name) || 'text'
      )
    end
    Inferno::TestRunner.new(test_session:, test_run:).run(runnable)
  end

  it 'passes if successful FHIR API request for Patient resource with _id parameter' do
    allow(test).to receive(:suite).and_return(suite)

    create_fhir_api_request(body: JSON.parse(c4bb_patient_search_bundle.to_json))

    result = run(test, access_token:)
    expect(result.result).to eq('pass')
  end

  it 'passes if successful FHIR search request for EOB resource with patient resource included with _include param' do
    allow(test).to receive(:suite).and_return(suite)

    create_fhir_api_request(url: eob_include_search, body: JSON.parse(c4bb_eob_include_bundle.to_json),
                            tags: eob_include_search_tags)

    result = run(test, access_token:)
    expect(result.result).to eq('pass')
  end

  it 'fails if Patient with unexpected ID returned from server' do
    allow(test).to receive(:suite).and_return(suite)

    c4bb_patient_search_bundle.entry.first.resource.id = 999
    create_fhir_api_request(body: JSON.parse(c4bb_patient_search_bundle.to_json))

    result = run(test, access_token:)
    expect(result.result).to eq('fail')
    expect(result.result_message).to eq('Unable to find expected resource: 888')
  end

  it 'skips if no requests were made that returned Patient resources' do
    allow(test).to receive(:suite).and_return(suite)

    c4bb_eob_include_bundle['entry'].reject do |entry|
      entry['resource']['resourceType'] == 'Patient'
    end
    create_fhir_api_request(url: eob_include_search, body: JSON.parse(c4bb_eob_include_bundle.to_json),
                            tags: eob_include_search_tags - ['Patient'])

    result = run(test, access_token:)
    expect(result.result).to eq('skip')
    expect(result.result_message).to eq('No requests made for Patient resources')
  end
end
