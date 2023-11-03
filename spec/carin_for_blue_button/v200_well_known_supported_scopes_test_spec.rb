# frozen_string_literal: true

RSpec.describe CarinForBlueButtonTestKit::CARIN4BBV200::WellKnownSupportedScopesTest do
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
  let(:well_known_config) do
    {
      scopes_supported: required_scopes
    }
  end
  let(:well_known_config_bad) do
    {
      scopes_supported: []
    }
  end
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
  let(:test_config) do
    Inferno::DSL::Configurable::Configuration.new(options: { required_scopes: })
  end
  before do
    allow_any_instance_of(test).to(receive(:config).and_return(test_config))
  end

  it 'passes if all required scopes are advertised in the Well-known configuration`' do
    inputs = { well_known_configuration: JSON.generate(well_known_config) }

    result = run(test, inputs)

    expect(result.result).to eq('pass')
  end

  it 'fails if all required scopes are not advertised in the Well-known configuration`' do
    inputs = { well_known_configuration: JSON.generate(well_known_config_bad) }

    result = run(test, inputs)

    expect(result.result).to eq('fail')
  end
end
