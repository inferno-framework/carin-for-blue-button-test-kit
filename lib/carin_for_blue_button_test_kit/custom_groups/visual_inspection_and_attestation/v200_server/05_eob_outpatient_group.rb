require_relative '05_eob_outpatient_group/attestation_test_requirement_157'
require_relative '05_eob_outpatient_group/attestation_test_requirement_158'
require_relative '05_eob_outpatient_group/attestation_test_requirement_159'

module CarinForBlueButtonTestKit
  class CarinEOBOutpatientAttestationGroup < Inferno::TestGroup
    id :c4bb_eob_outpatient
    title 'Explanation of Benefit - Outpatient Institutional'
    short_title 'EOB Outpatient Institutional'

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@157',
                          'hl7.fhir.us.carin-bb_2.0.0@158',
                          'hl7.fhir.us.carin-bb_2.0.0@159'

    test from: :carin_server_requirement_157_attestation
    test from: :carin_server_requirement_158_attestation
    test from: :carin_server_requirement_159_attestation
  end
end
