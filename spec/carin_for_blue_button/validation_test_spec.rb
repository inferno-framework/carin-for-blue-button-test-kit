# frozen_string_literal: true

RSpec.describe CarinForBlueButtonTestKit::ValidationTest, :runnable do
  let(:patient_json_string) do
    File.read(File.join(__dir__, '..', 'fixtures', 'c4bb_patient_example.json'))
  end

  let(:suite_id) { 'c4bb_v200' }
  let(:error_outcome) { FHIR::OperationOutcome.new(issue: [{ severity: 'error' }]) }

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
    let(:patient_id) { 'Patient1' }

    before do
      patient_validation_test.id(SecureRandom.uuid)
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
