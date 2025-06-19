require_relative '08_eob_nonclinician_group/attestation_test_requirement_168_170'
require_relative '08_eob_nonclinician_group/attestation_test_requirement_173'

module CarinForBlueButtonTestKit
  class CarinEOBNonClinicianAttestationGroup < Inferno::TestGroup
    id :c4bb_eob_nonclinician
    title 'Explanation of Benefit - Professional NonClinician'
    short_title 'EOB Professional NonClinician'

    test from: :carin_server_requirement_168_170_attestation
    test from: :carin_server_requirement_173_attestation
  end
end
