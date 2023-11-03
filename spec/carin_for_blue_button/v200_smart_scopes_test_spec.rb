# frozen_string_literal: true

RSpec.describe CarinForBlueButtonTestKit::CARIN4BBV200::SmartScopesTest do
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

  let(:test) { described_class }
  let(:test_session) { repo_create(:test_session, test_suite_id: 'c4bb_v200') }
  let(:session_data_repo) { Inferno::Repositories::SessionData.new }
  let(:required_scopes) do
    %w[
      openid
      fhirUser
      launch/patient
      patient/ExplanationOfBenefit.read
      patient/Coverage.read
      patient/Patient.read
      patient/Organization.read
      patient/Practitioner.read
      user/ExplanationOfBenefit.read
      user/Coverage.read
      user/Patient.read
      user/Organization.read
      user/Practitioner.read
    ]
  end

  before do
    repo_create(:request, test_session_id: test_session.id, name: :token)
    allow_any_instance_of(test).to receive(:required_scopes).and_return(required_scopes)
  end

  context 'with received scopes' do
    let(:requested_scopes) { required_scopes.join(' ') }

    it 'passes if the received scopes grant access to all required resource types' do
      result = run(test, requested_scopes:, received_scopes: required_scopes.join(' '))

      expect(result.result).to eq('pass')
    end

    it 'fails if the received scopes do not grant access to all required resource types' do
      result = run(test, requested_scopes:, received_scopes: 'patient/Patient.read')

      expect(result.result).to eq('fail')
    end
  end

  context 'with requested scopes' do
    it 'fails if a required scope was not requested' do
      result = run(test, requested_scopes: 'online_access launch')

      expect(result.result).to eq('fail')
      expect(result.result_message).to include('Required scopes were not requested: ')
    end
  end
end
