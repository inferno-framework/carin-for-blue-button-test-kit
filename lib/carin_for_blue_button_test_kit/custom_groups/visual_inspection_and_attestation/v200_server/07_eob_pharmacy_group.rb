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

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@161',
                          'hl7.fhir.us.carin-bb_2.0.0@162',
                          'hl7.fhir.us.carin-bb_2.0.0@163',
                          'hl7.fhir.us.carin-bb_2.0.0@164',
                          'hl7.fhir.us.carin-bb_2.0.0@165'

    test from: :carin_server_requirement_161_attestation
    test from: :carin_server_requirement_162_attestation
    test from: :carin_server_requirement_163_attestation
    test from: :carin_server_requirement_164_attestation
    test from: :carin_server_requirement_165_attestation
  end
end
