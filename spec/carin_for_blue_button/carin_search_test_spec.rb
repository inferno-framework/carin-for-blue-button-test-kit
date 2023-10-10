# frozen_string_literal: true

RSpec.describe CarinForBlueButtonTestKit::CarinSearchTest do
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

  def setup_mock_test(search_test, eob_resource)
    allow_any_instance_of(search_test).to receive(:scratch_resources).and_return(
      {
        all: [eob_resource]
      }
    )
  end

  describe 'carin search requiring service-date' do
    let(:service_date_search_test) do
      Class.new(Inferno::Test) do
        include CarinForBlueButtonTestKit::CarinSearchTest

        def properties
          @properties ||= CarinForBlueButtonTestKit::SearchTestProperties.new(
            resource_type: 'ExplanationOfBenefit',
            search_param_names: ['service-date']
          )
        end

        def self.metadata
          @metadata ||=
            CarinForBlueButtonTestKit::Generator::GroupMetadata.new(
              YAML.load_file(
                File.join(
                  __dir__,
                  '..',
                  'fixtures',
                  'eob_metadata_v200.yml'
                ),
                aliases: true
              )
            )
        end

        def scratch_resources
          scratch[:explanation_of_benefit_resources] ||= {}
        end

        fhir_client { url :url }
        input :url, :service_date

        run do
          run_search_test(service_date)
        end
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

      result = run(service_date_search_test, service_date:, url:)
      expect(result.result).to eq('pass')
    end

    it 'fails if a 400 is received' do
      stub_request(:get, "#{url}/ExplanationOfBenefit?service-date=#{service_date}")
        .to_return(status: 400, body: bundle.to_json)

      result = run(service_date_search_test, service_date:, url:)

      expect(result.result).to eq('fail')
      expect(result.result_message).to eq('Unexpected response status: expected 200, but received 400')
    end
  end

  describe 'carin search requiring service-start-date' do
    let(:service_start_date_search_test) do
      Class.new(Inferno::Test) do
        include CarinForBlueButtonTestKit::CarinSearchTest

        def properties
          @properties ||= CarinForBlueButtonTestKit::SearchTestProperties.new(
            resource_type: 'ExplanationOfBenefit',
            search_param_names: ['service-start-date']
          )
        end

        def self.metadata
          @metadata ||=
            CarinForBlueButtonTestKit::Generator::GroupMetadata.new(
              YAML.load_file(
                File.join(
                  __dir__,
                  '..',
                  'fixtures',
                  'eob_metadata_v200.yml'
                ),
                aliases: true
              )
            )
        end

        def scratch_resources
          scratch[:explanation_of_benefit_resources] ||= {}
        end

        fhir_client { url :url }
        input :url, :service_start_date

        run do
          run_search_test(service_start_date)
        end
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

      result = run(service_start_date_search_test, service_start_date:, url:)
      expect(result.result).to eq('pass')
    end

    it 'fails if a 400 is received' do
      stub_request(:get, "#{url}/ExplanationOfBenefit?service-start-date=#{service_start_date}")
        .to_return(status: 400, body: bundle.to_json)

      result = run(service_start_date_search_test, service_start_date:, url:)

      expect(result.result).to eq('fail')
      expect(result.result_message).to eq('Unexpected response status: expected 200, but received 400')
    end
  end

  describe 'carin search requiring billable-period-start' do
    let(:billable_period_start_search_test) do
      Class.new(Inferno::Test) do
        include CarinForBlueButtonTestKit::CarinSearchTest

        def properties
          @properties ||= CarinForBlueButtonTestKit::SearchTestProperties.new(
            resource_type: 'ExplanationOfBenefit',
            search_param_names: ['billable-period-start']
          )
        end

        def self.metadata
          @metadata ||=
            CarinForBlueButtonTestKit::Generator::GroupMetadata.new(
              YAML.load_file(
                File.join(
                  __dir__,
                  '..',
                  'fixtures',
                  'eob_metadata_v200.yml'
                ),
                aliases: true
              )
            )
        end

        def scratch_resources
          scratch[:explanation_of_benefit_resources] ||= {}
        end

        fhir_client { url :url }
        input :url, :billable_period_start

        run do
          run_search_test(billable_period_start)
        end
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

      result = run(billable_period_start_search_test, billable_period_start:, url:)
      expect(result.result).to eq('pass')
    end

    it 'fails if a 400 is received' do
      stub_request(:get, "#{url}/ExplanationOfBenefit?billable-period-start=#{billable_period_start}")
        .to_return(status: 400, body: bundle.to_json)

      result = run(billable_period_start_search_test, billable_period_start:, url:)

      expect(result.result).to eq('fail')
      expect(result.result_message).to eq('Unexpected response status: expected 200, but received 400')
    end
  end
end
