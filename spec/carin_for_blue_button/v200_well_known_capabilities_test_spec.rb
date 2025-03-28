# frozen_string_literal: true

RSpec.describe CarinForBlueButtonTestKit::CARIN4BBV200DEVNONFINANCIAL::WellKnownCapabilitiesTest do
  let(:test) { described_class }
  let(:suite_id) { 'c4bb_v200' }
  let(:well_known_config) do
    {
      capabilities: required_capabilities
    }
  end
  let(:well_known_config_bad) do
    {
      capabilities: []
    }
  end
  let(:required_capabilities) do
    %w[
      launch-standalone
      client-public
      client-confidential-symmetric
      sso-openid-connect
      context-standalone-patient
      permission-offline
      permission-patient
      permission-user
    ]
  end
  let(:test_config) do
    Inferno::DSL::Configurable::Configuration.new(options: { required_capabilities: })
  end
  before do
    allow_any_instance_of(test).to(receive(:config).and_return(test_config))
  end

  it 'passes if all required capabilities are advertised in the Well-known configuration`' do
    inputs = { well_known_configuration: JSON.generate(well_known_config) }

    result = run(test, inputs)

    expect(result.result).to eq('pass')
  end

  it 'fails if all required capabilities are not advertised in the Well-known configuration`' do
    inputs = { well_known_configuration: JSON.generate(well_known_config_bad) }

    result = run(test, inputs)

    expect(result.result).to eq('fail')
  end
end
