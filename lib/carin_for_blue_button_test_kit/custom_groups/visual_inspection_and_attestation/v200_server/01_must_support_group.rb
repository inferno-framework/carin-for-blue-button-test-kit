require_relative '01_must_support_group/attestation_test_requirement_2'
require_relative '01_must_support_group/attestation_test_requirement_5'
require_relative '01_must_support_group/attestation_test_requirement_7'
require_relative '01_must_support_group/attestation_test_requirement_9'
require_relative '01_must_support_group/attestation_test_requirement_10'

module CarinForBlueButtonTestKit
  class CarinMustSupportAttestationGroup < Inferno::TestGroup
    id :c4bb_must_support
    title 'Must Support'
    short_title 'Must Support'

    test from: :carin_server_requirement_2_attestation
    test from: :carin_server_requirement_5_attestation
    test from: :carin_server_requirement_7_attestation
    test from: :carin_server_requirement_9_attestation
    test from: :carin_server_requirement_10_attestation
  end
end
