RSpec.describe CarinForBlueButtonTestKit::MustSupportTest do
    
    let(:patient_include_test) { Inferno::Repositories::Tests.new.find('c4bb_v110_explanation_of_benefit_include_ExplanationOfBenefit_patient_search_test')}

    # copied from us-core-test-kit
    let(:suite) { Inferno::Repositories::TestSuites.new.find('c4bb_v200') }
    let(:session_data_repo) { Inferno::Repositories::SessionData.new }
    let(:test_session) { repo_create(:test_session, test_suite_id: suite.id) }
    let(:url) { 'http://example.com/fhir' }

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

    def execute_mock_test(bundle_resource)
      allow_any_instance_of(patient_include_test)
      .to receive(:scratch_resources).and_return(
      {
          all: [bundle_resource]
      }
      )
      return run(patient_include_test)
    end

  describe 'search ExplanationofBenefit with patient inclusion' do
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