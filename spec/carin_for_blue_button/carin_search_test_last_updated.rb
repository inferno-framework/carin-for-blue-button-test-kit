# frozen_string_literal: true

RSpec.describe CarinForBlueButtonTestKit::CarinSearchTest do
    let(:coverage_json_string) do
      File.read(File.join(__dir__, '..', 'fixtures', 'c4bb_coverage_example.json'))
    end

    let(:eob_json_string) do
        File.read(File.join(__dir__, '..', 'fixtures', 'c4bb_eob_inpatient_example.json'))
    end
  
    let(:suite) { Inferno::Repositories::TestSuites.new.find('c4bb_v200') }
    let(:session_data_repo) { Inferno::Repositories::SessionData.new }
    let(:test_session) { repo_create(:test_session, test_suite_id: suite.id) }
    let(:url) { 'http://example.com/fhir' }
    let(:error_outcome) { FHIR::OperationOutcome.new(issue: [{ severity: 'error' }]) }
  
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
  
    def setup_mock_test(coverage_test, coverage_resource)
      allow_any_instance_of(coverage_test).to receive(:scratch_resources).and_return(
        {
          all: [coverage_resource]
        }
      )
    end
  
    describe 'carin coverage search optional _lastUpdated' do
      let(:coverage_last_updated_search_test) do
        Class.new(CarinForBlueButtonTestKit::CARIN4BBV200::CoverageLastupdatedSearchTest) do
          fhir_client { url :url }
          input :url
        end
      end
  
      let(:coverage) { FHIR.from_contents(coverage_json_string) }
      let(:last_updated) { '2022-09-17' }
      let(:bundle) do
        FHIR::Bundle.new(entry: [{ resource: coverage }])
      end
  
      before do
        Inferno::Repositories::Tests.new.insert(coverage_last_updated_search_test)
        setup_mock_test(coverage_last_updated_search_test, coverage)
      end
  
      it 'passes if _lastUpdated is passed in and 200 is received' do
        stub_request(:get, "#{url}/Coverage?_lastUpdated=#{last_updated}")
          .to_return(status: 200, body: bundle.to_json)
  
        result = run(
          coverage_last_updated_search_test,
          c4bb_v200_coverage__lastUpdated_search_test_param: last_updated,
          url:
        )
        expect(result.result).to eq('pass')
      end

      it 'skips if _lastUpdated is passed in and 400 is received' do
        stub_request(:get, "#{url}/Coverage?_lastUpdated=#{last_updated}")
          .to_return(status: 400, body: error_outcome.to_json)
        result = run(
          coverage_last_updated_search_test,
          c4bb_v200_coverage__lastUpdated_search_test_param: last_updated,
          url:
        )
        expect(result.result).to eq('skip')
        expect(result.result_message).to eq('_lastUpdated search query was unsuccessful and did not respond with a 200 status')
      end

      it 'skips if _lastUpdated is not passed in' do
        result = run(
          coverage_last_updated_search_test,
          url:
        )
        expect(result.result).to eq('skip')
        expect(result.result_message).to eq('_lastUpdated optional and not provided')
      end
  end

  describe 'carin eob search required _lastUpdated' do
    let(:eob_last_updated_search_test) do
      Class.new(CarinForBlueButtonTestKit::CARIN4BBV200::ExplanationOfBenefitLastupdatedSearchTest) do
        fhir_client { url :url }
        input :url
      end
    end

    let(:eob) { FHIR.from_contents(eob_json_string) }
    let(:last_updated) { '2020-04-28' }
    let(:bundle) do
      FHIR::Bundle.new(entry: [{ resource: eob }])
    end

    before do
      Inferno::Repositories::Tests.new.insert(eob_last_updated_search_test)
      setup_mock_test(eob_last_updated_search_test, eob)
    end

    it 'passes if _lastUpdated is passed in and 200 is received' do
      stub_request(:get, "#{url}/ExplanationOfBenefit?_lastUpdated=#{last_updated}")
        .to_return(status: 200, body: bundle.to_json)

      result = run(
        eob_last_updated_search_test,
        c4bb_v200_explanation_of_benefit__lastUpdated_search_test_param: last_updated,
        url:
      )
      expect(result.result).to eq('pass')
    end

    it 'fails if lastUpdated is passed in and 400 is received' do
      stub_request(:get, "#{url}/ExplanationOfBenefit?_lastUpdated=#{last_updated}")
        .to_return(status: 400, body: error_outcome.to_json)

      result = run(
        eob_last_updated_search_test,
        c4bb_v200_explanation_of_benefit__lastUpdated_search_test_param: last_updated,
        url:
      )
      expect(result.result).to eq('fail')
      expect(result.result_message).to eq('Unexpected response status: expected 200, but received 400')
    end

    it 'fails if lastUpdated is not passed in' do
      stub_request(:get, "#{url}/ExplanationOfBenefit?_lastUpdated")
        .to_return(status: 400, body: error_outcome.to_json)
      
      result = run(
        eob_last_updated_search_test,
        url:
      )
      expect(result.result).to eq('fail')
      expect(result.result_message).to eq('Unexpected response status: expected 200, but received 400')
    end
end


end