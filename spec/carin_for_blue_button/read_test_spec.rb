RSpec.describe CarinForBlueButtonTestKit::ReadTest do
  let(:patient_json_string) do
    File.read(File.join(__dir__, '..', 'fixtures', 'c4bb_patient_example.json'))
  end

  let(:organization_json_string) do
    File.read(File.join(__dir__, '..', 'fixtures', 'c4bb_organization_example.json'))
  end

  let(:suite) { Inferno::Repositories::TestSuites.new.find('c4bb_v200') }
  let(:session_data_repo) { Inferno::Repositories::SessionData.new }
  let(:test_session) { repo_create(:test_session, test_suite_id: suite.id) }
  let(:url) { 'http://example.com/fhir' }
  let(:error_outcome) { FHIR::OperationOutcome.new(issue: [{ severity: 'error' }]) }

  let(:patient) { FHIR.from_contents(patient_json_string) }
  let(:patient2) { FHIR.from_contents(patient_json_string) }
  let(:organization) { FHIR.from_contents(organization_json_string) }
  let(:patient_id_1) { 'Patient1' }
  let(:patient_id_2) { 'Patient2' }
  let(:patient_ids) { 'Patient1, Patient2' }

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

  def setup_mock_test(search_test, patient_resources)
    allow_any_instance_of(search_test).to receive(:scratch_resources).and_return(
      {
        all: patient_resources
      }
    )
  end

  describe 'patient read test' do
    let(:patient_read_test) do
      Class.new(CarinForBlueButtonTestKit::CARIN4BBV200::PatientReadTest) do
        fhir_client { url :url }
        input :url, :patient_ids
      end
    end

    before do
      patient_read_test.id(SecureRandom.uuid)
      Inferno::Repositories::Tests.new.insert(patient_read_test)
      patient2.id = 'Patient2'
      patientarr = [patient, patient2]
      setup_mock_test(patient_read_test, patientarr)
    end

    it 'passes if a 200 is received with valid patient' do
      request = stub_request(:get, "#{url}/Patient/#{patient_id_1}")
                .to_return(status: 200, body: patient.to_json)

      result = run(patient_read_test, url:, patient_ids: patient_id_1)
      expect(result.result).to eq('pass')
      expect(request).to have_been_made.once
    end

    it 'passes reading only first of 2 valid patients' do
      request1 = stub_request(:get, "#{url}/Patient/#{patient_id_1}")
                 .to_return(status: 200, body: patient.to_json)

      request2 = stub_request(:get, "#{url}/Patient/#{patient_id_2}")
                 .to_return(status: 200, body: patient2.to_json)

      result = run(
        patient_read_test,
        url:,
        patient_ids:
      )
      expect(result.result).to eq('pass')
      expect(request1).to have_been_made.once
      expect(request2).not_to have_been_made
    end

    it 'fails if a 400 is received' do
      request = stub_request(:get, "#{url}/Patient/#{patient_id_1}")
                .to_return(status: 400, body: patient.to_json)

      result = run(
        patient_read_test,
        url:,
        patient_ids: patient_id_1
      )
      expect(result.result).to eq('fail')
      expect(result.result_message).to eq('Unexpected response status: expected 200, but received 400')
      expect(request).to have_been_made.once
    end

    it 'skips if no patient resource was retrieved in previous tests' do
      setup_mock_test(patient_read_test, [])

      result = run(patient_read_test, url:)
      expect(result.result).to eq('skip')
    end

    it 'fails if incorrect resource type is returned' do
      request = stub_request(:get, "#{url}/Patient/#{patient_id_1}")
                .to_return(status: 200, body: organization.to_json)

      result = run(
        patient_read_test,
        url:,
        patient_ids: patient_id_1
      )
      expect(result.result).to eq('fail')
      expect(result.result_message).to eq('Unexpected resource type: expected Patient, but received Organization')
      expect(request).to have_been_made.once
    end
  end

  describe 'multiple patient read test' do
    let(:multiple_patient_read_test) do
      Class.new(CarinForBlueButtonTestKit::CARIN4BBV200::PatientReadTest) do
        fhir_client { url :url }
        config(
          options: {
            read_all_resources: true
          }
        )
        input :url, :patient_ids
      end
    end

    before do
      multiple_patient_read_test.id(SecureRandom.uuid)
      Inferno::Repositories::Tests.new.insert(multiple_patient_read_test)
      patient2.id = 'Patient2'
      patientarr = [patient, patient2]
      setup_mock_test(multiple_patient_read_test, patientarr)
    end

    it 'passes if a 200 is received with 2 valid patients' do
      request1 = stub_request(:get, "#{url}/Patient/#{patient_id_1}")
                 .to_return(status: 200, body: patient.to_json)

      request2 = stub_request(:get, "#{url}/Patient/#{patient_id_2}")
                 .to_return(status: 200, body: patient2.to_json)

      result = run(
        multiple_patient_read_test,
        url:,
        patient_ids:
      )
      expect(result.result).to eq('pass')
      expect(request1).to have_been_made.once
      expect(request2).to have_been_made.once
    end
  end
end
