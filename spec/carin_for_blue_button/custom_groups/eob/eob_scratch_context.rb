RSpec.shared_context 'eob_scratch_context' do
  def run_with_eob_scratch_context(eob_test, eob_array)
    run(eob_test, { url: }, { explanationofbenefit_resources: { all: eob_array } })
  end
end
