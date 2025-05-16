require_relative '00_authorization_group/attestation_test_requirement_48'
require_relative '00_authorization_group/attestation_test_requirement_60'
require_relative '00_authorization_group/attestation_test_requirement_97'

module CarinForBlueButtonTestKit
  class CarinSecurityAttestationGroup < Inferno::TestGroup
    id :c4bb_security
    title 'Security'
    short_title 'Security'

    test from: :carin_server_requirement_97_attestation
    test from: :carin_server_requirement_48_57_attestation
    test from: :carin_server_requirement_60_67_attestation
  end
end
