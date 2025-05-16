require_relative '07_eob_pharmacy_group/attestation_test_requirement_161'
require_relative '07_eob_pharmacy_group/attestation_test_requirement_162'
require_relative '07_eob_pharmacy_group/attestation_test_requirement_163'
require_relative '07_eob_pharmacy_group/attestation_test_requirement_164'
require_relative '07_eob_pharmacy_group/attestation_test_requirement_165'

module CarinForBlueButtonTestKit
  class CarinEOBPharmacyAttestationGroup < Inferno::TestGroup
    id :c4bb_eob_pharmacy
    title 'Explanation of Benefit - Pharmacy'
    short_title 'EOB Pharmacy'

    test from: :carin_server_requirement_161_attestation
    test from: :carin_server_requirement_162_attestation
    test from: :carin_server_requirement_163_attestation
    test from: :carin_server_requirement_164_attestation
    test from: :carin_server_requirement_165_attestation
  end
end
