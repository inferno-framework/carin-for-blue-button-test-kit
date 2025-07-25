require_relative 'eob_scratch_context'

RSpec.describe CarinForBlueButtonTestKit::CARIN4BBV200::TypeDataAbsentTest do
  include_context 'eob_scratch_context'

  let(:eob_json_string) do
    File.read(File.join(__dir__, '..', '..', '..', 'fixtures', 'c4bb_eob_inpatient_example.json'))
  end
  let(:eob_bundle_json_string) do
    File.read(File.join(__dir__, '..', '..', '..', 'fixtures', 'c4bb_eob_include_bundle.json'))
  end

  let(:suite_id) { 'c4bb_v200' }
  let(:url) { 'http://example.com/fhir' }
  let(:error_outcome) { FHIR::OperationOutcome.new(issue: [{ severity: 'error' }]) }

  describe 'Requires EOB.type to not have a data absent reason' do
    let(:eob_type_data_absent_test) do
      Class.new(CarinForBlueButtonTestKit::CARIN4BBV200::TypeDataAbsentTest) do
        fhir_client { url :url }
        input :url
      end
    end

    let(:eob) { FHIR.from_contents(eob_json_string) }
    let(:eob2) { FHIR.from_contents(eob_bundle_json_string).entry.first.resource }

    it 'passes if no data absent reason' do
      result = run_with_eob_scratch_context(eob_type_data_absent_test, [eob])
      expect(result.result).to eq('pass')
    end

    it 'fails if a data absent reason is used' do
      result = run_with_eob_scratch_context(eob_type_data_absent_test, [eob2])
      expect(result.result).to eq('fail')
    end
  end
end
