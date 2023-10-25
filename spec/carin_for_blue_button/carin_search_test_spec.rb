# frozen_string_literal: true

RSpec.describe CarinForBlueButtonTestKit::CarinSearchTest do
  let(:eob_json_string) do
    File.read(File.join(__dir__, '..', 'fixtures', 'c4bb_eob_inpatient_example.json'))
  end

  let(:patient_json_string) do
    File.read(File.join(__dir__, '..', 'fixtures', 'c4bb_patient_example.json'))
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

  def setup_mock_test(search_test, resource)
    allow_any_instance_of(search_test).to receive(:scratch_resources).and_return(
      {
        all: [resource]
      }
    )
  end

  describe 'carin search requiring service-date' do
    let(:service_date_search_test) do
      Class.new(CarinForBlueButtonTestKit::CARIN4BBV200::ExplanationOfBenefitServiceDateSearchTest) do
        fhir_client { url :url }
        input :url
      end
    end

    let(:service_date) { '2017-05-23' }
    let(:eob) { FHIR.from_contents(eob_json_string) }
    let(:bundle) do
      FHIR::Bundle.new(entry: [{ resource: eob }])
    end

    before do
      Inferno::Repositories::Tests.new.insert(service_date_search_test)
      setup_mock_test(service_date_search_test, eob)
    end

    it 'passes if a 200 is received' do
      stub_request(:get, "#{url}/ExplanationOfBenefit?service-date=#{service_date}")
        .to_return(status: 200, body: bundle.to_json)

      result = run(
        service_date_search_test,
        c4bb_v200_explanation_of_benefit_service_date_search_test_param: service_date,
        url:
      )
      expect(result.result).to eq('pass')
    end

    it 'fails if a 400 is received' do
      stub_request(:get, "#{url}/ExplanationOfBenefit?service-date=#{service_date}")
        .to_return(status: 400, body: bundle.to_json)

      result = run(
        service_date_search_test,
        c4bb_v200_explanation_of_benefit_service_date_search_test_param: service_date,
        url:
      )

      expect(result.result).to eq('fail')
      expect(result.result_message).to eq('Unexpected response status: expected 200, but received 400')
    end
  end

  describe 'carin search requiring service-start-date' do
    let(:service_start_date_search_test) do
      Class.new(CarinForBlueButtonTestKit::CARIN4BBV200::ExplanationOfBenefitServiceStartDateSearchTest) do
        fhir_client { url :url }
        input :url
      end
    end

    let(:service_start_date) { '2017-05-23' }
    let(:eob) { FHIR.from_contents(eob_json_string) }
    let(:bundle) do
      FHIR::Bundle.new(entry: [{ resource: eob }])
    end

    before do
      Inferno::Repositories::Tests.new.insert(service_start_date_search_test)
      setup_mock_test(service_start_date_search_test, eob)
    end

    it 'passes if a 200 is received' do
      stub_request(:get, "#{url}/ExplanationOfBenefit?service-start-date=#{service_start_date}")
        .to_return(status: 200, body: bundle.to_json)

      result = run(
        service_start_date_search_test,
        c4bb_v200_explanation_of_benefit_service_start_date_search_test_param: service_start_date,
        url:
      )
      expect(result.result).to eq('pass')
    end

    it 'fails if a 400 is received' do
      stub_request(:get, "#{url}/ExplanationOfBenefit?service-start-date=#{service_start_date}")
        .to_return(status: 400, body: bundle.to_json)

      result = run(
        service_start_date_search_test,
        c4bb_v200_explanation_of_benefit_service_start_date_search_test_param: service_start_date,
        url:
      )

      expect(result.result).to eq('fail')
      expect(result.result_message).to eq('Unexpected response status: expected 200, but received 400')
    end
  end

  describe 'carin search requiring billable-period-start' do
    let(:billable_period_start_search_test) do
      Class.new(CarinForBlueButtonTestKit::CARIN4BBV200::ExplanationOfBenefitBillablePeriodStartSearchTest) do
        fhir_client { url :url }
        input :url
      end
    end

    let(:billable_period_start) { '2017-05-23' }
    let(:eob) { FHIR.from_contents(eob_json_string) }
    let(:bundle) do
      FHIR::Bundle.new(entry: [{ resource: eob }])
    end

    before do
      Inferno::Repositories::Tests.new.insert(billable_period_start_search_test)
      setup_mock_test(billable_period_start_search_test, eob)
    end

    it 'passes if a 200 is received' do
      stub_request(:get, "#{url}/ExplanationOfBenefit?billable-period-start=#{billable_period_start}")
        .to_return(status: 200, body: bundle.to_json)

      result = run(
        billable_period_start_search_test,
        c4bb_v200_explanation_of_benefit_billable_period_start_search_test_param: billable_period_start,
        url:
      )
      expect(result.result).to eq('pass')
    end

    it 'fails if a 400 is received' do
      stub_request(:get, "#{url}/ExplanationOfBenefit?billable-period-start=#{billable_period_start}")
        .to_return(status: 400, body: bundle.to_json)

      result = run(
        billable_period_start_search_test,
        c4bb_v200_explanation_of_benefit_billable_period_start_search_test_param: billable_period_start,
        url:
      )

      expect(result.result).to eq('fail')
      expect(result.result_message).to eq('Unexpected response status: expected 200, but received 400')
    end
  end

  describe 'carin search requiring type' do
    let(:type_search_test) do
      Class.new(CarinForBlueButtonTestKit::CARIN4BBV200::ExplanationOfBenefitTypeSearchTest) do
        fhir_client { url :url }
        input :url
      end
    end

    let(:type) { 'institutional' }
    let(:eob) { FHIR.from_contents(eob_json_string) }
    let(:bundle) do
      FHIR::Bundle.new(entry: [{ resource: eob }])
    end

    before do
      Inferno::Repositories::Tests.new.insert(type_search_test)
      setup_mock_test(type_search_test, eob)
    end

    it 'passes if a 200 is received' do
      stub_request(:get, "#{url}/ExplanationOfBenefit?type=#{type}")
        .to_return(status: 200, body: bundle.to_json)

      result = run(
        type_search_test,
        c4bb_v200_explanation_of_benefit_type_search_test_param: type,
        url:
      )
      expect(result.result).to eq('pass')
    end

    it 'fails if a 400 is received' do
      stub_request(:get, "#{url}/ExplanationOfBenefit?type=#{type}")
        .to_return(status: 400, body: bundle.to_json)

      result = run(
        type_search_test,
        c4bb_v200_explanation_of_benefit_type_search_test_param: type,
        url:
      )

      expect(result.result).to eq('fail')
      expect(result.result_message).to eq('Unexpected response status: expected 200, but received 400')
    end
  end

  describe 'carin search requiring _id' do
    let(:_id_search_test) do
      Class.new(CarinForBlueButtonTestKit::CARIN4BBV200::PatientIdSearchTest) do
        fhir_client { url :url }
        input :url
      end
    end

    let(:_id) { 'Patient1,Patient2' }
    let(:patient) { FHIR.from_contents(patient_json_string) }
    let(:bundle) do
      FHIR::Bundle.new(entry: [{ resource: patient }])
    end

    before do
      Inferno::Repositories::Tests.new.insert(_id_search_test)
      setup_mock_test(_id_search_test, patient)
    end

    it 'passes if a 200 is received' do
      stub_request(:get, "#{url}/Patient?_id=#{_id}")
        .to_return(status: 200, body: bundle.to_json)

      result = run(
        _id_search_test,
        patient_ids: _id,
        url:
      )
      expect(result.result).to eq('pass')
    end

    it 'fails if a 400 is received' do
      stub_request(:get, "#{url}/Patient?_id=#{_id}")
        .to_return(status: 400, body: bundle.to_json)

      result = run(
        _id_search_test,
        patient_ids: _id,
        url:
      )

      expect(result.result).to eq('fail')
      expect(result.result_message).to eq('Unexpected response status: expected 200, but received 400')
    end
  end

  describe 'carin Coverage search optional _lastUpdated' do
    let(:coverage_last_updated_search_test) do
      Class.new(CarinForBlueButtonTestKit::CARIN4BBV200::CoverageLastupdatedSearchTest) do
        fhir_client { url :url }
        input :url
      end
    end

    let(:coverage_json_string) do
      File.read(File.join(__dir__, '..', 'fixtures', 'c4bb_coverage_example.json'))
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

    it 'fails if _lastUpdated is passed in and 400 is received' do
      stub_request(:get, "#{url}/Coverage?_lastUpdated=#{last_updated}")
        .to_return(status: 400, body: error_outcome.to_json)
      result = run(
        coverage_last_updated_search_test,
        c4bb_v200_coverage__lastUpdated_search_test_param: last_updated,
        url:
      )
      expect(result.result).to eq('fail')
      expect(result.result_message).to eq('Unexpected response status: expected 200, but received 400')
    end

    it 'skips if _lastUpdated is not passed in' do
      stub_request(:get, "#{url}/Coverage?_lastUpdated")
        .to_return(status: 400, body: error_outcome.to_json)
      result = run(
        coverage_last_updated_search_test,
        url:
      )
      expect(result.result).to eq('skip')
      expect(result.result_message).to eq("Coverage search parameter for _lastUpdated not provided")
    end
  end

  describe 'carin ExplanationOfBenefit search required _lastUpdated' do
    let(:eob_last_updated_search_test) do
      Class.new(CarinForBlueButtonTestKit::CARIN4BBV200::ExplanationOfBenefitLastupdatedSearchTest) do
        fhir_client { url :url }
        input :url
      end
    end

    let(:eob_json_string) do
      File.read(File.join(__dir__, '..', 'fixtures', 'c4bb_eob_inpatient_example.json'))
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
  end

end
