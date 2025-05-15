require_relative '08_eob_nonclinician_group/attestation_test_requirement_168_170'
require_relative '08_eob_nonclinician_group/attestation_test_requirement_173'

module CarinForBlueButtonTestKit
  class CarinEOBNonClinicianAttestationGroup < Inferno::TestGroup
    id :c4bb_eob_nonclinician
    title 'Explanation of Benefit - Professional NonClinician'
    short_title 'EOB Professional NonClinician'

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@168',
                          'hl7.fhir.us.carin-bb_2.0.0@170',
                          'hl7.fhir.us.carin-bb_2.0.0@173'

    test from: :carin_server_requirement_168_170_attestation
    test from: :carin_server_requirement_173_attestation
  end
end
