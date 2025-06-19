require_relative '03_eob_group/attestation_test_requirement_105'
require_relative '03_eob_group/attestation_test_requirement_108'
require_relative '03_eob_group/attestation_test_requirement_115'
require_relative '03_eob_group/attestation_test_requirement_116'
require_relative '03_eob_group/attestation_test_requirement_118'
require_relative '03_eob_group/attestation_test_requirement_119'
require_relative '03_eob_group/attestation_test_requirement_120'
require_relative '03_eob_group/attestation_test_requirement_124'

module CarinForBlueButtonTestKit
  class CarinEOBAttestationGroup < Inferno::TestGroup
    id :c4bb_eob
    title 'Explanation of Benefit'
    short_title 'Explanation of Benefit (EOB)'

    test from: :carin_server_requirement_105_attestation
    test from: :carin_server_requirement_108_attestation
    test from: :carin_server_requirement_115_attestation
    test from: :carin_server_requirement_116_117_attestation
    test from: :carin_server_requirement_118_attestation
    test from: :carin_server_requirement_119_attestation
    test from: :carin_server_requirement_120_attestation
    test from: :carin_server_requirement_124_125_127_128_129_attestation
  end
end
