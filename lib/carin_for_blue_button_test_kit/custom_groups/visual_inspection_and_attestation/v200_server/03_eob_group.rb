require_relative '03_eob_group/attestation_test_requirement_105'
require_relative '03_eob_group/attestation_test_requirement_108'
require_relative '03_eob_group/attestation_test_requirement_118'
require_relative '03_eob_group/attestation_test_requirement_119'
require_relative '03_eob_group/attestation_test_requirement_120'

module CarinForBlueButtonTestKit
  class CarinEOBAttestationGroup < Inferno::TestGroup
    id :c4bb_eob
    title 'Explanation of Benefit'
    short_title 'Explanation of Benefit (EOB)'

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@105',
                          'hl7.fhir.us.carin-bb_2.0.0@108',
                          'hl7.fhir.us.carin-bb_2.0.0@118',
                          'hl7.fhir.us.carin-bb_2.0.0@119',
                          'hl7.fhir.us.carin-bb_2.0.0@120'

    test from: :carin_server_requirement_105_attestation
    test from: :carin_server_requirement_108_attestation
    test from: :carin_server_requirement_118_attestation
    test from: :carin_server_requirement_119_attestation
    test from: :carin_server_requirement_120_attestation
  end
end
