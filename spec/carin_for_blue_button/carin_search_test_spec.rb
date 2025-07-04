RSpec.describe CarinForBlueButtonTestKit::CarinSearchTest, :runnable do
  let(:eob_json_string) do
    File.read(File.join(__dir__, '..', 'fixtures', 'c4bb_eob_inpatient_example.json'))
  end

  let(:suite_id) { 'c4bb_v200' }
  let(:url) { 'http://example.com/fhir' }
  let(:error_outcome) { FHIR::OperationOutcome.new(issue: [{ severity: 'error' }]) }

  def setup_mock_test(search_test, eob_resource)
    allow_any_instance_of(search_test).to receive(:scratch_resources).and_return(
      {
        all: [eob_resource]
      }
    )
  end

  describe 'carin search requiring service-date' do
    let(:service_date_search_test) do
      Class.new(CarinForBlueButtonTestKit::CARIN4BBV200::EobServiceDateSearchTest) do
        fhir_client { url :url }
        input :url
      end
    end

    let(:service_date) { 'gt2017-05-22T00:00:00%2B00:00' }
    let(:eob) { FHIR.from_contents(eob_json_string) }
    let(:bundle) do
      FHIR::Bundle.new(entry: [{ resource: eob }])
    end

    before do
      service_date_search_test.id(SecureRandom.uuid)
      Inferno::Repositories::Tests.new.insert(service_date_search_test)
      setup_mock_test(service_date_search_test, eob)
    end

    it 'passes if a 200 is received' do
      stub_request(:get, "#{url}/ExplanationOfBenefit?service-date=#{service_date}")
        .to_return(status: 200, body: bundle.to_json)

      result = run(service_date_search_test, url:)
      expect(result.result).to eq('pass')
    end

    it 'fails if a 400 is received' do
      stub_request(:get, "#{url}/ExplanationOfBenefit?service-date=#{service_date}")
        .to_return(status: 400, body: bundle.to_json)

      result = run(
        service_date_search_test, url:
      )

      expect(result.result).to eq('fail')
      expect(result.result_message).to eq('Unexpected response status: expected 200, but received 400')
    end
  end

  describe 'carin search requiring service-start-date' do
    let(:service_start_date_search_test) do
      Class.new(CarinForBlueButtonTestKit::CARIN4BBV200::EobServiceStartDateSearchTest) do
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
      service_start_date_search_test.id(SecureRandom.uuid)
      Inferno::Repositories::Tests.new.insert(service_start_date_search_test)
      setup_mock_test(service_start_date_search_test, eob)
    end

    it 'passes if a 200 is received' do
      stub_request(:get, "#{url}/ExplanationOfBenefit?service-start-date=#{service_start_date}")
        .to_return(status: 200, body: bundle.to_json)

      result = run(service_start_date_search_test, url:)
      expect(result.result).to eq('pass')
    end

    it 'fails if a 400 is received' do
      stub_request(:get, "#{url}/ExplanationOfBenefit?service-start-date=#{service_start_date}")
        .to_return(status: 400, body: bundle.to_json)

      result = run(service_start_date_search_test, url:)

      expect(result.result).to eq('fail')
      expect(result.result_message).to eq('Unexpected response status: expected 200, but received 400')
    end
  end

  describe 'carin search requiring billable-period-start' do
    let(:billable_period_start_search_test) do
      Class.new(CarinForBlueButtonTestKit::CARIN4BBV200::EobBillablePeriodStartSearchTest) do
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
      billable_period_start_search_test.id(SecureRandom.uuid)
      Inferno::Repositories::Tests.new.insert(billable_period_start_search_test)
      setup_mock_test(billable_period_start_search_test, eob)
    end

    it 'passes if a 200 is received' do
      stub_request(:get, "#{url}/ExplanationOfBenefit?billable-period-start=#{billable_period_start}")
        .to_return(status: 200, body: bundle.to_json)

      result = run(billable_period_start_search_test, url:)
      expect(result.result).to eq('pass')
    end

    it 'fails if a 400 is received' do
      stub_request(:get, "#{url}/ExplanationOfBenefit?billable-period-start=#{billable_period_start}")
        .to_return(status: 400, body: bundle.to_json)

      result = run(billable_period_start_search_test, url:)

      expect(result.result).to eq('fail')
      expect(result.result_message).to eq('Unexpected response status: expected 200, but received 400')
    end
  end

  describe 'carin search requiring type' do
    let(:type_search_test) do
      Class.new(CarinForBlueButtonTestKit::CARIN4BBV200::EobTypeSearchTest) do
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
      type_search_test.id(SecureRandom.uuid)
      Inferno::Repositories::Tests.new.insert(type_search_test)
      setup_mock_test(type_search_test, eob)
    end

    it 'passes if a 200 is received' do
      stub_request(:get, "#{url}/ExplanationOfBenefit?type=#{type}")
        .to_return(status: 200, body: bundle.to_json)

      result = run(type_search_test, url:)
      expect(result.result).to eq('pass')
    end

    it 'fails if a 400 is received' do
      stub_request(:get, "#{url}/ExplanationOfBenefit?type=#{type}")
        .to_return(status: 400, body: bundle.to_json)

      result = run(type_search_test, url:)

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
      id_search_test.id(SecureRandom.uuid)
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
    let(:last_updated) { '2022-09-17T20:32:39.267%2B00:00' }
    let(:bundle) do
      FHIR::Bundle.new(entry: [{ resource: coverage }])
    end

    before do
      coverage_last_updated_search_test.id(SecureRandom.uuid)
      Inferno::Repositories::Tests.new.insert(coverage_last_updated_search_test)
      setup_mock_test(coverage_last_updated_search_test, coverage)
    end

    it 'passes if _lastUpdated is passed in and 200 is received' do
      stub_request(:get, "#{url}/Coverage?_lastUpdated=#{last_updated}")
        .to_return(status: 200, body: bundle.to_json)

      result = run(coverage_last_updated_search_test, url:)
      expect(result.result).to eq('pass')
    end

    it 'fails if _lastUpdated is passed in and 400 is received' do
      stub_request(:get, "#{url}/Coverage?_lastUpdated=#{last_updated}")
        .to_return(status: 400, body: error_outcome.to_json)
      result = run(coverage_last_updated_search_test, url:)
      expect(result.result).to eq('fail')
      expect(result.result_message).to eq('Unexpected response status: expected 200, but received 400')
    end

    it 'skips if _lastUpdated is not passed in' do
      allow_any_instance_of(coverage_last_updated_search_test).to receive(:scratch_resources).and_return(
        {
          all: []
        }
      )
      stub_request(:get, "#{url}/Coverage?_lastUpdated")
        .to_return(status: 400, body: error_outcome.to_json)
      result = run(coverage_last_updated_search_test, url:)
      expect(result.result).to eq('skip')
    end
  end

  describe 'carin ExplanationOfBenefit search required _lastUpdated' do
    let(:eob_last_updated_search_test) do
      Class.new(CarinForBlueButtonTestKit::CARIN4BBV200::EobLastupdatedSearchTest) do
        fhir_client { url :url }
        input :url
      end
    end

    let(:eob_json_string) do
      File.read(File.join(__dir__, '..', 'fixtures', 'c4bb_eob_inpatient_example.json'))
    end

    let(:eob) { FHIR.from_contents(eob_json_string) }
    let(:last_updated) { '2020-04-28T15:39:36-04:00' }
    let(:bundle) do
      FHIR::Bundle.new(entry: [{ resource: eob }])
    end

    before do
      eob_last_updated_search_test.id(SecureRandom.uuid)
      Inferno::Repositories::Tests.new.insert(eob_last_updated_search_test)
      setup_mock_test(eob_last_updated_search_test, eob)
    end

    it 'passes if _lastUpdated is passed in and 200 is received' do
      stub_request(:get, "#{url}/ExplanationOfBenefit?_lastUpdated=#{last_updated}")
        .to_return(status: 200, body: bundle.to_json)

      result = run(eob_last_updated_search_test, url:)
      expect(result.result).to eq('pass')
    end

    it 'fails if lastUpdated is passed in and 400 is received' do
      stub_request(:get, "#{url}/ExplanationOfBenefit?_lastUpdated=#{last_updated}")
        .to_return(status: 400, body: error_outcome.to_json)

      result = run(eob_last_updated_search_test, url:)
      expect(result.result).to eq('fail')
      expect(result.result_message).to eq('Unexpected response status: expected 200, but received 400')
    end
  end

  describe 'search ExplanationofBenefit with _include patient param' do
    let(:explanation_of_benefit_include_test_patient) do
      Class.new(CarinForBlueButtonTestKit::CARIN4BBV200::EobExplanationOfBenefit_patientSearchTest) do
        fhir_client { url :url }
        input :url
      end
    end

    let(:search_params_patient) { '_id=EOBProfessionalTransportation1&_include=ExplanationOfBenefit:patient' }
    let(:explanation_of_benefit_id) { 'EOBProfessionalTransportation1' }
    let(:patient_id) { '123' }
    let(:patient_id_2) { '456' }
    let(:patient) { FHIR::Patient.new(id: patient_id) }
    let(:patient2) { FHIR::Patient.new(id: patient_id_2) }
    let(:organization) { FHIR::Organization.new(id: patient_id) }
    let(:explanation_of_benefit) do
      FHIR::ExplanationOfBenefit.new(
        id: explanation_of_benefit_id,
        patient: {
          reference: "Patient/#{patient_id}"
        }
      )
    end

    let(:bundle) do
      FHIR::Bundle.new(entry: [{ resource: explanation_of_benefit }, { resource: patient }])
    end

    before do
      explanation_of_benefit_include_test_patient.id(SecureRandom.uuid)
      Inferno::Repositories::Tests.new.insert(explanation_of_benefit_include_test_patient)
      setup_mock_test(explanation_of_benefit_include_test_patient, explanation_of_benefit)
    end

    it 'passes performing an _include search for ExplanationOfBenefit:patient' do
      request = stub_request(:get, "#{url}/ExplanationOfBenefit?#{search_params_patient}")
                .to_return(status: 200, body: bundle.to_json)

      result = run(explanation_of_benefit_include_test_patient, url:)
      expect(result.result).to eq('pass')
      expect(request).to have_been_made.once
    end

    it 'fails performing an _include search for ExplanationOfBenefit:patient when there is patient resource with incorrect id' do
      # Expect that test fails when patient resource with correct id is not present in bundle
      bundle.entry[-1].resource.id = patient_id_2

      request = stub_request(:get, "#{url}/ExplanationOfBenefit?#{search_params_patient}")
                .to_return(status: 200, body: bundle.to_json)

      result = run(explanation_of_benefit_include_test_patient, url:)
      expect(result.result).to eq('fail')
      expect(result.result_message).to eq('No ExplanationOfBenefit references Patient/456 in the search result.')
      expect(request).to have_been_made.once
    end

    it 'passes performing an _include search for ExplanationOfBenefit:patient when there are no patient resources in the bundle' do
      # Expect that test passes when organization resource instead of patient resource is included in the bundle
      bundle.entry[-1] = { resource: organization }

      request = stub_request(:get, "#{url}/ExplanationOfBenefit?#{search_params_patient}")
                .to_return(status: 200, body: bundle.to_json)

      result = run(explanation_of_benefit_include_test_patient, url:)
      expect(result.result).to eq('pass')
      expect(request).to have_been_made.once
    end

    it 'fails performing an _include search for ExplanationOfBenefit:patient when there is an unreferenced patient resource in the bundle' do
      # Expect that test fails when a patient resource is included in the bundle but no base resource references it
      bundle.entry.push({ resource: patient2 })

      request = stub_request(:get, "#{url}/ExplanationOfBenefit?#{search_params_patient}")
                .to_return(status: 200, body: bundle.to_json)

      result = run(explanation_of_benefit_include_test_patient, url:)
      expect(result.result).to eq('fail')
      expect(result.result_message).to eq('No ExplanationOfBenefit references Patient/456 in the search result.')
      expect(request).to have_been_made.once
    end
  end

  describe 'search ExplanationofBenefit with _include * param' do
    let(:patient_id_2) { '456' }
    let(:patient2) { FHIR::Patient.new(id: patient_id_2) }
    let(:explanation_of_benefit) do
      FHIR::ExplanationOfBenefit.new(
        id: explanation_of_benefit_id,
        patient: {
          reference: "Patient/#{patient_id_2}"
        }
      )
    end

    let(:explanation_of_benefit_include_test_all) do
      Class.new(CarinForBlueButtonTestKit::CARIN4BBV200::EobExplanationOfBenefit_AllSearchTest) do
        fhir_client { url :url }
        input :url
      end
    end

    let(:search_params_all) { '_id=EOBProfessionalTransportation1&_include=ExplanationOfBenefit:*' }
    let(:explanation_of_benefit_id) { 'EOBProfessionalTransportation1' }

    let(:bundle_all) do
      FHIR.from_contents(File.read(File.join(__dir__, '..', 'fixtures', 'explanation_of_benefit_all.json')))
    end

    before do
      explanation_of_benefit_include_test_all.id(SecureRandom.uuid)
      Inferno::Repositories::Tests.new.insert(explanation_of_benefit_include_test_all)
      setup_mock_test(explanation_of_benefit_include_test_all, explanation_of_benefit)
    end

    it 'passes performing an _include search for ExplanationOfBenefit:*' do
      request = stub_request(:get, "#{url}/ExplanationOfBenefit?#{search_params_all}")
                .to_return(status: 200, body: bundle_all.to_json)

      # Test include with * parameter to ensure all resources are included
      result = run(explanation_of_benefit_include_test_all, url:)
      expect(result.result).to eq('pass')
      expect(request).to have_been_made.once
    end

    it 'fails performing an _include search for ExplanationOfBenefit:* when there is an unreferenced patient resource in the bundle' do
      # Expect that test fails when a patient resource is included in the bundle but no base resource references it
      bundle_all.entry.push({ resource: patient2 })

      request = stub_request(:get, "#{url}/ExplanationOfBenefit?#{search_params_all}")
                .to_return(status: 200, body: bundle_all.to_json)

      # Test include with * parameter to ensure all resources are included
      result = run(explanation_of_benefit_include_test_all, url:)
      expect(result.result).to eq('fail')
      expect(result.result_message).to eq('No ExplanationOfBenefit references Patient/456 in the search result.')
      expect(request).to have_been_made.once
    end

    it 'fails performing an _include search for ExplanationOfBenefit:* when there is an unreferenced patient resource in the bundle with same id as another resouce' do
      # Expect that test fails when a patient resource is included in the bundle but no base resource references it
      patient2.id = 'Payer2'
      bundle_all.entry.push({ resource: patient2 })

      request = stub_request(:get, "#{url}/ExplanationOfBenefit?#{search_params_all}")
                .to_return(status: 200, body: bundle_all.to_json)

      # Test include with * parameter to ensure all resources are included
      result = run(explanation_of_benefit_include_test_all, url:)
      expect(result.result).to eq('fail')
      expect(result.result_message).to eq('No ExplanationOfBenefit references Patient/Payer2 in the search result.')
      expect(request).to have_been_made.once
    end
  end
end
