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

  describe 'carin Patient _id search test' do
    let(:id_search_test) do
      Class.new(CarinForBlueButtonTestKit::CARIN4BBV200::PatientIdSearchTest) do
        fhir_client { url :url }
        input :url
      end
    end

    let(:patient_json_string) do
      File.read(File.join(__dir__, '..', 'fixtures', 'c4bb_patient_example.json'))
    end

    let(:patient_id) { 'Patient1' }
    let(:patient) { FHIR.from_contents(patient_json_string) }
    let(:bundle) do
      FHIR::Bundle.new(entry: [{ resource: patient }])
    end
    let(:empty_bundle) do
      FHIR::Bundle.new(entry: [])
    end

    before do
      Inferno::Repositories::Tests.new.insert(id_search_test)
      setup_mock_test(id_search_test, patient)
    end

    context 'when single patient search' do
      it 'passes if a 200 is received' do
        stub_request(:get, "#{url}/Patient?_id=#{patient_id}")
          .to_return(status: 200, body: bundle.to_json)

        result = run(
          id_search_test,
          patient_ids: patient_id,
          url:
        )
        expect(result.result).to eq('pass')
      end
    end

    context 'when multiple patients search' do
      it 'passes if a 200 is received and all responses are not empty bundles' do
        stub_request(:get, "#{url}/Patient?_id=#{patient_id}")
          .to_return(status: 200, body: bundle.to_json)
        stub_request(:get, "#{url}/Patient?_id=Patient1")
          .to_return(status: 200, body: bundle.to_json)
        result = run(
          id_search_test,
          patient_ids: 'Patient1, Patient1',
          url:
        )
        expect(result.result).to eq('pass')
      end

      it 'passes if a 200 is received and some responses are empty bundles' do
        stub_request(:get, "#{url}/Patient?_id=#{patient_id}")
          .to_return(status: 200, body: bundle.to_json)
        stub_request(:get, "#{url}/Patient?_id=Patient2")
          .to_return(status: 200, body: empty_bundle.to_json)
        result = run(
          id_search_test,
          patient_ids: 'Patient2, Patient1',
          url:
        )
        expect(result.result).to eq('pass')
      end
    end

    it 'fails if a 400 is received' do
      stub_request(:get, "#{url}/Patient?_id=#{patient_id}")
        .to_return(status: 400, body: bundle.to_json)

      result = run(
        id_search_test,
        patient_ids: patient_id,
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
  describe 'search ExplanationofBenefit with _include param for patient' do
    context 'when the patient resources are contained' do
      let(:search_params_patient) {'_id=EOBProfessionalTransportation1&_include=ExplanationOfBenefit:patient'}
      let(:search_params_all) {'_id=EOBProfessionalTransportation1&_include=ExplanationOfBenefit:*'}
      let(:explanation_of_benefit_id) { 'EOBProfessionalTransportation1' }
      let(:patient_id) { '123' }
      let(:patient) { FHIR::Patient.new(id: patient_id) }
      let (:organization) { FHIR::Organization.new(id: patient_id) }
      let(:explanation_of_benefit) do
        FHIR::ExplanationOfBenefit.new(
          id: explanation_of_benefit_id,
          patient: {
            reference: "Patient/#{patient_id}"
          }
        )
      end
      let(:explanation_of_benefit_include_test) do
        Class.new(Inferno::Test) do
          include CarinForBlueButtonTestKit::CarinSearchTest

          def properties
            @properties ||= CarinForBlueButtonTestKit::SearchTestProperties.new(
              resource_type: 'ExplanationOfBenefit',
              search_param_names: ['_include']
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
                    'explanation_of_benefit_inclusion_metadata.yml'
                  )
                )
              )
          end

          def scratch_resources
            scratch[:patient_request_resources] ||= {}
          end

          fhir_client { url :url }
          input :url, :search_param, :c4bb_v200_explanation_of_benefit__id_search_test_param

          run do
            run_search_test(search_param, include_search: true, resource_id: c4bb_v200_explanation_of_benefit__id_search_test_param)
          end
        end
      end
      let (:bundle) do
        FHIR::Bundle.new(entry: [{resource: explanation_of_benefit}, {resource: patient}])
      end
      let(:bundle_all) do 
        FHIR.from_contents(File.read(File.join(__dir__, '..', 'fixtures', 'explanation_of_benefit_all.json')))
      end
      let(:test_scratch) { {} }

      before do
        Inferno::Repositories::Tests.new.insert(explanation_of_benefit_include_test)
        allow_any_instance_of(explanation_of_benefit_include_test)
          .to receive(:scratch).and_return(test_scratch)
      end

      it 'passes performing an _include search for ExplanationOfBenefit:patient' do
        # Match any request that doesn't contain '_include'
        request = stub_request(:get, "#{url}/ExplanationOfBenefit?#{search_params_patient}")
          .to_return(status: 200, body: bundle.to_json)

        result = run(explanation_of_benefit_include_test, search_param: 'ExplanationOfBenefit:patient', c4bb_v200_explanation_of_benefit__id_search_test_param: explanation_of_benefit_id, url: url)
        expect(result.result).to eq('pass')
        expect(request).to have_been_made.once
      end

      
      it 'passes performing an _include search for ExplanationOfBenefit:*' do
        request = stub_request(:get, "#{url}/ExplanationOfBenefit?#{search_params_all}")
          .to_return(status: 200, body: bundle_all.to_json)
        
        # Test include with * parameter to ensure all resources are included
        result = run(explanation_of_benefit_include_test, search_param: 'ExplanationOfBenefit:*', c4bb_v200_explanation_of_benefit__id_search_test_param: explanation_of_benefit_id, url: url)
        expect(result.result).to eq('pass')
        expect(request).to have_been_made.once
      end

      it 'fails performing an _include search for ExplanationOfBenefit:patient when there is patient resource with incorrect id' do
        # Expect that test fails when patient resource with correct id is not present in bundle
        bundle.entry[-1].resource.id = '456'

        request = stub_request(:get, "#{url}/ExplanationOfBenefit?#{search_params_patient}")
          .to_return(status: 200, body: bundle.to_json)

        result = run(explanation_of_benefit_include_test, search_param: 'ExplanationOfBenefit:patient', c4bb_v200_explanation_of_benefit__id_search_test_param: explanation_of_benefit_id, url: url)
        expect(result.result).to eq('fail')
        expect(result.result_message).to eq('Returned resource did not include the _include resource parameter')
        expect(request).to have_been_made.once
      end

      it 'fails performing an _include search for ExplanationOfBenefit:patient when reference id is formatted incorrectly' do
        # Expect that test fails when Explanation of Benefit patient reference id is in incorrect format
        bundle.entry[0].resource.patient.reference = '#Patient1'

        request = stub_request(:get, "#{url}/ExplanationOfBenefit?#{search_params_patient}")
          .to_return(status: 200, body: bundle.to_json)

        result = run(explanation_of_benefit_include_test, search_param: 'ExplanationOfBenefit:patient', c4bb_v200_explanation_of_benefit__id_search_test_param: explanation_of_benefit_id, url: url)
        expect(result.result).to eq('fail')
        expect(result.result_message).to eq('Reference id is not in the correct format of [ResourceType]/[ResourceID]')
        expect(request).to have_been_made.once
      end

      it 'fails performing an _include search for ExplanationOfBenefit:patient when there is the wrong resource with correct id' do
        
        # Expect that test fails when only organization resource with correct patient id is present in bundle
        bundle.entry[-1] = {resource: organization}

        request = stub_request(:get, "#{url}/ExplanationOfBenefit?#{search_params_patient}")
          .to_return(status: 200, body: bundle.to_json)

        result = run(explanation_of_benefit_include_test, search_param: 'ExplanationOfBenefit:patient', c4bb_v200_explanation_of_benefit__id_search_test_param: explanation_of_benefit_id, url: url)
        expect(result.result).to eq('fail')
        expect(result.result_message).to eq('No Patient resources were included in the search results')
        expect(request).to have_been_made.once
      end
    end
  end

end
