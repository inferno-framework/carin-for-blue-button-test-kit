RSpec.describe CarinForBlueButtonTestKit::CARIN4BBV200::InsurerSameTest do
  let(:eob_json_string) do
    File.read(File.join(__dir__, '..', '..', '..', 'fixtures', 'c4bb_eob_inpatient_example.json'))
  end
  let(:organization_json_string) do
    File.read(File.join(__dir__, '..', '..', '..', 'fixtures', 'c4bb_organization_example.json'))
  end
  let(:coverage_json_string) do
    File.read(File.join(__dir__, '..', '..', '..', 'fixtures', 'c4bb_coverage_example.json'))
  end
  let(:coverage_secondary_json_string) do
    File.read(File.join(__dir__, '..', '..', '..', 'fixtures', 'c4bb_eob_coverage_example.json'))
  end

  let(:suite_id) { 'c4bb_v200' }
  let(:url) { 'http://example.com/fhir' }
  let(:error_outcome) { FHIR::OperationOutcome.new(issue: [{ severity: 'error' }]) }

  def execute_mock_test(eob_test, eob_resource)
    allow_any_instance_of(eob_test).to receive(:scratch_resources).and_return(
                                         {
                                           all: [eob_resource]
                                         }
                                       )
    run(eob_test, url:) # TODO scratch arg
  end

  describe 'Requires primary insurance to match insurer' do
    let(:eob_insurer_same_test) do
      Class.new(CarinForBlueButtonTestKit::CARIN4BBV200::InsurerSameTest) do
        fhir_client { url :url }
        input :url
      end
    end

    let(:eob) { FHIR.from_contents(eob_json_string) }
    let(:organization) { FHIR.from_contents(organization_json_string) }
    let(:coverage) { FHIR.from_contents(coverage_json_string) }
    let(:coverage_secondary) { FHIR.from_contents(coverage_secondary_json_string) }

    it 'passes if the primary insurance matches the insurer and all others do not' do
      stub_request(:get, "#{url}/Organization/c4bb-Organization")
        .to_return(status: 200, body: organization.to_json)
      stub_request(:get, "#{url}/Coverage/c4bb-coverage")
        .to_return(status: 200, body: coverage.to_json)
      stub_request(:get, "#{url}/Coverage/Coverage2")
        .to_return(status: 200, body: coverage_secondary.to_json)

      result = execute_mock_test(eob_insurer_same_test, eob)
      expect(result.result).to eq('pass')
    end

    it 'fails if the primary insurance does not match the insurer' do
      stub_request(:get, "#{url}/Organization/c4bb-Organization")
        .to_return(status: 200, body: organization.to_json)
      # reverse coverage
      stub_request(:get, "#{url}/Coverage/c4bb-coverage")
      .to_return(status: 200, body: coverage_secondary.to_json)
      stub_request(:get, "#{url}/Coverage/Coverage2")
       .to_return(status: 200, body: coverage.to_json)

      result = execute_mock_test(eob_insurer_same_test, eob)
      expect(result.result).to eq('fail')
    end
  end
end
