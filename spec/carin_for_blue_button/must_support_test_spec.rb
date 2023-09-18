RSpec.describe CarinForBlueButtonTestKit::MustSupportTest do
    puts "Must support test!"
    let(:json_string) do 
        File.read(File.join(__dir__, '..', 'fixtures', 'c4bb_patient_example.json'))
    end 

    let(:patient_resource) { FHIR.from_contents(json_string) }

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
    
    # it 'prints out the contents' do
    #     puts json_string
    # end

    # it 'creates a resource' do 
    #     puts patient_resource.id
    # end

    it 'runs the actual test and returns a result' do
        allow_any_instance_of(patient_must_support_test)
        .to receive(:scratch_resources).and_return(
          {
            all: [patient_resource]
          }
        )
        
        result = run(patient_must_support_test)
        puts result.result_message
    end

end
