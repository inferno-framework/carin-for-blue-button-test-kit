require_relative 'eob_scratch_context'

RSpec.describe CarinForBlueButtonTestKit::CARIN4BBV200::OutcomeCompleteTest do
  include_context 'eob_scratch_context'

  let(:eob_complete_json_string) do
    File.read(File.join(__dir__, '..', '..', '..', 'fixtures', 'c4bb_eob_inpatient_example.json'))
  end
  let(:eob_partial_bundle_json_string) do
    File.read(File.join(__dir__, '..', '..', '..', 'fixtures', 'c4bb_eob_include_bundle.json'))
  end

  let(:suite_id) { 'c4bb_v200' }
  let(:url) { 'http://example.com/fhir' }
  let(:error_outcome) { FHIR::OperationOutcome.new(issue: [{ severity: 'error' }]) }

  describe 'eob requiring outcome complete' do
    let(:eob_outcome_complete_test) do
      Class.new(CarinForBlueButtonTestKit::CARIN4BBV200::OutcomeCompleteTest) do
        fhir_client { url :url }
        input :url
      end
    end

    let(:eob_complete) { FHIR.from_contents(eob_complete_json_string) }
    let(:eob_partial) { FHIR.from_contents(eob_partial_bundle_json_string).entry.first.resource }

    it 'passes if an outcome is complete' do
      result = run_with_eob_scratch_context(eob_outcome_complete_test, [eob_complete])
      expect(result.result).to eq('pass')
    end

    it 'fails if an outcome is not complete' do
      result = run_with_eob_scratch_context(eob_outcome_complete_test, [eob_partial])
      expect(result.result).to eq('fail')
    end
  end
end
