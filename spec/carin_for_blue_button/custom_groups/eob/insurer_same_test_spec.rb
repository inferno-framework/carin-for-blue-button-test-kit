RSpec.describe CarinForBlueButtonTestKit::CARIN4BBV200::InsurerSameTest do
  let(:eob_json_string) do
    File.read(File.join(__dir__, '..', '..', '..', 'fixtures', 'c4bb_eob_inpatient_example.json'))
  end
  let(:coverage_json_string) do
    File.read(File.join(__dir__, '..', '..', '..', 'fixtures', 'c4bb_eob_coverage_example.json'))
  end
  let(:coverage_secondary_json_string) do
    File.read(File.join(__dir__, '..', '..', '..', 'fixtures', 'c4bb_coverage_example.json'))
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
    run(eob_test, { url: }, { explanationofbenefit_resources: [eob_resource] })
  end

  describe 'Requires primary insurance to match insurer' do
    # Use `test` instead of `described_class` to make sure the full id is loaded
    let(:test) { find_test suite, described_class.id }
    let(:eob) { FHIR.from_contents(eob_json_string) }
    let(:coverage) { FHIR.from_contents(coverage_json_string) }
    let(:coverage_secondary) { FHIR.from_contents(coverage_secondary_json_string) }

    around(:example) do |example|
      # reverse coverage
      coverage_stub = stub_request(:get, "#{url}/Coverage/c4bb-eob-coverage")
                        .to_return(status: 200, body: coverage_secondary.to_json)
      coverage2_stub = stub_request(:get, "#{url}/Coverage/Coverage2")
                         .to_return(status: 200, body: coverage.to_json)

      example.run

      #expect(coverage_stub).to have_been_made
      #expect(coverage2_stub).to have_been_made
    end

    it 'passes if the primary insurance matches the insurer and all others do not' do
      result = execute_mock_test(test, eob)
      expect(result.result).to eq('pass'), result.result_message
    end

    it 'fails if the primary insurance does not match the insurer' do
      bad_organization = FHIR::Organization.new({id: 'bad'})
      eob.insurer = bad_organization.to_reference

      result = execute_mock_test(test, eob)
      expect(result.result).to eq('fail')
    end
  end
end
