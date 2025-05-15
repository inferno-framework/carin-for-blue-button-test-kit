require_relative '01_must_support_group/attestation_test_requirement_2'
require_relative '01_must_support_group/attestation_test_requirement_5'

module CarinForBlueButtonTestKit
  class CarinMustSupportAttestationGroup < Inferno::TestGroup
    id :c4bb_must_support
    title 'Must Support'
    short_title 'Must Support'

    test from: :carin_server_requirement_2_attestation
    test from: :carin_server_requirement_5_attestation
  end
end
