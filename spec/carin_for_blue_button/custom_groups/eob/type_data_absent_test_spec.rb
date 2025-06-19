RSpec.describe CarinForBlueButtonTestKit::CARIN4BBV200::TypeDataAbsentTest do
  let(:eob_json_string) do
    File.read(File.join(__dir__, '..', '..', '..', 'fixtures', 'c4bb_eob_inpatient_example.json'))
  end
  let(:eob_bundle_json_string) do
    File.read(File.join(__dir__, '..', '..', '..', 'fixtures', 'c4bb_eob_include_bundle.json'))
  end

  let(:suite_id) { 'c4bb_v200' }
  let(:url) { 'http://example.com/fhir' }
  let(:error_outcome) { FHIR::OperationOutcome.new(issue: [{ severity: 'error' }]) }

  def execute_mock_test(eob_test, eob_resource)
    allow_any_instance_of(eob_test)
      .to receive(:scratch_resources).and_return(
        {
          all: [eob_resource]
        }
      )

    run(eob_test, url:) # TODO: remove stub and pass scratch arg
  end

  describe 'Requires EOB.type to not have a data absent reason' do
    let(:eob_type_data_absent_test) do
      Class.new(CarinForBlueButtonTestKit::CARIN4BBV200::TypeDataAbsentTest) do
        fhir_client { url :url }
        input :url
      end
    end

    let(:eob) { FHIR.from_contents(eob_json_string) }
    let(:eob2) { FHIR.from_contents(eob_bundle_json_string).entry.first.resource }

    it 'passes if an outcome is complete' do
      result = execute_mock_test(eob_type_data_absent_test, eob)
      expect(result.result).to eq('pass')
    end

    it 'fails if an outcome is not complete' do
      result = execute_mock_test(eob_type_data_absent_test, eob2)
      expect(result.result).to eq('fail')
    end
  end
end
