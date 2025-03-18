# frozen_string_literal: true

RSpec.describe CarinForBlueButtonTestKit::CARIN4BBV200::SmartScopesTest do
  let(:test) { described_class }
  let(:suite_id) { 'c4bb_v200' }
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

  context 'All required scopes are not requested' do
    it 'fails if a required scope was not requested' do
      result = run(
        test,
        smart_auth_info: Inferno::DSL::AuthInfo.new(requested_scopes: 'online_access launch'),
        received_scopes: 'launch'
      )

      expect(result.result).to eq('fail')
      expect(result.result_message).to include('Required scopes were not requested: ')
    end
  end

  context 'All required scopes requested' do
    it 'fails if all the required scopes were not granted' do
      result = run(
        test,
        smart_auth_info: Inferno::DSL::AuthInfo.new(requested_scopes: required_scopes.join(' ')),
        received_scopes: 'patient/*.*'
      )

      expect(result.result).to eq('fail')
    end

    it 'passes if the granted scopes are the super set of the required requested scopes' do
      result = run(
        test,
        smart_auth_info: Inferno::DSL::AuthInfo.new(requested_scopes: required_scopes.join(' ')),
        received_scopes: 'patient/*.* user/*.* openid fhirUser launch/patient'
      )

      expect(result.result).to eq('pass')
    end

    it 'passes if the granted scopes are the exact required requested scopes' do
      result = run(
        test,
        smart_auth_info: Inferno::DSL::AuthInfo.new(requested_scopes: required_scopes.join(' ')),
        received_scopes: required_scopes.join(' ')
      )

      expect(result.result).to eq('pass')
    end
  end
end
