require_relative '05_eob_outpatient_group/attestation_test_requirement_157'
require_relative '05_eob_outpatient_group/attestation_test_requirement_156'

module CarinForBlueButtonTestKit
  class CarinEOBOutpatientAttestationGroup < Inferno::TestGroup
    id :c4bb_eob_outpatient
    title 'Explanation of Benefit - Outpatient Institutional'
    short_title 'EOB Outpatient Institutional'

    test from: :carin_server_requirement_156_attestation
    test from: :carin_server_requirement_157_158_159_attestation
  end
end
