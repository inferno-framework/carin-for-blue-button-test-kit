require_relative '11_crosscutting_group/adjudication_amount'
require_relative '11_crosscutting_group/amount_calculations'
require_relative '11_crosscutting_group/coverage_reference_resource'
require_relative '11_crosscutting_group/meta_lastupdated'
require_relative '11_crosscutting_group/licensing'
require_relative '11_crosscutting_group/attestation_test_requirement_19'
require_relative '11_crosscutting_group/attestation_test_requirement_28'
require_relative '11_crosscutting_group/attestation_test_requirement_99'

module CarinForBlueButtonTestKit
  class CarinCrossCuttingAttestationGroup < Inferno::TestGroup
    id :c4bb_crosscutting
    title 'Cross Cutting'

    test from: :carin_licensing_test
    test from: :coverage_reference_resource
    test from: :amount_calculations
    test from: :adjudication_amount
    test from: :meta_last_updated
    test from: :carin_server_requirement_19_attestation
    test from: :carin_server_requirement_28_attestation
    test from: :carin_server_requirement_99_attestation
  end
end
