# frozen_string_literal: true

RSpec.describe CarinForBlueButtonTestKit::ValidationTest do
    let(:patient_json_string) do
      File.read(File.join(__dir__, '..', 'fixtures', 'c4bb_patient_example.json'))
    end
  
    let(:suite) { Inferno::Repositories::TestSuites.new.find('c4bb_v200') }
    let(:session_data_repo) { Inferno::Repositories::SessionData.new }
    let(:test_session) { repo_create(:test_session, test_suite_id: suite.id) }
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
  
    def setup_mock_test(search_test, patient_resources)
      allow_any_instance_of(search_test).to receive(:scratch_resources).and_return(
        {
          all: patient_resources
        }
      )
    end
  
    describe 'patient validation test' do
      let(:patient_validation_test) do
        Class.new(CarinForBlueButtonTestKit::CARIN4BBV200::PatientValidationTest)
      end
  
      let(:patient_arr) { [FHIR.from_contents(patient_json_string)] }
      let (:patient_id) { "Patient1" }
  
      before do
        Inferno::Repositories::Tests.new.insert(patient_validation_test)
        setup_mock_test(patient_validation_test, patient_arr)
      end
  
      it 'passes if patient resource passes validation check' do

        allow_any_instance_of(patient_validation_test).to receive(:resource_is_valid?).and_return(true)
        result = run(
            patient_validation_test
        )
        expect(result.result).to eq('pass')
      end
    end
end