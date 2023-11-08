RSpec.describe CarinForBlueButtonTestKit::MustSupportTest do

  let(:json_string_stub) do
    File.read(File.join(__dir__, '..', 'fixtures', 'c4bb_patient_stub.json'))
  end

  let(:patient_must_support_test) { Inferno::Repositories::Tests.new.find('c4bb_v200_patient_must_support_test')}

  # copied from us-core-test-kit
  let(:suite) { Inferno::Repositories::TestSuites.new.find('c4bb_v200') }
  let(:session_data_repo) { Inferno::Repositories::SessionData.new }
  let(:test_session) { repo_create(:test_session, test_suite_id: suite.id) }

  def run(runnable, inputs = {})
    test_run_params = { test_session_id: test_session.id }.merge(runnable.reference_hash)
    test_run = Inferno::Repositories::TestRuns.new.create(test_run_params)
    inputs.each do |name, value|
      session_data_repo.save(
      test_session_id: test_session.id,
      name: name,
      value: value,
      type: runnable.config.input_type(name)
      )
    end
    Inferno::TestRunner.new(test_session: test_session, test_run: test_run).run(runnable)
  end


  def generate_patient_resource(json_addition)
    complete_json_string = json_string_stub + json_addition
    return FHIR.from_contents(complete_json_string)
  end

  def execute_mock_test(patient_resource)
    allow_any_instance_of(patient_must_support_test)
    .to receive(:scratch_resources).and_return(
    {
      all: [patient_resource]
    }
    )
    return run(patient_must_support_test)
  end

  describe 'must support test for choice elements with correct deceased inputs' do
    def run_expect_pass(patient_resource)
      result = execute_mock_test(patient_resource)
      expect(result.result).to eq('pass')
    end

    it 'supports deceasedDateTime type when parsing from file' do
      json_string = File.read(File.join(__dir__, '..', 'fixtures', 'c4bb_patient_example.json'))
      run_expect_pass(FHIR.from_contents(json_string))
    end

    it 'supports deceasedBoolean type' do
      deceased_boolean = ', "deceasedBoolean" : "false"
      }'

      run_expect_pass(generate_patient_resource(deceased_boolean))
    end
  end

  describe 'must support test for choice elements with incorrect deceased inputs' do

    def run_expect_error(patient_resource)
      result = execute_mock_test(patient_resource)
      expect(result.result).to eq('skip')
      expect(result.result_message).to include('deceased[x]')
    end

    it 'fails when deceased not present' do
      run_expect_error(generate_patient_resource('}'))
    end
  end
end