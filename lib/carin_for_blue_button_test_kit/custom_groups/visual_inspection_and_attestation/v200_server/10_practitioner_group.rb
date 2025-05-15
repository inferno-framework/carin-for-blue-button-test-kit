require_relative '10_practitioner_group/attestation_test_requirement_186'

module CarinForBlueButtonTestKit
  class CarinPractitionerAttestationGroup < Inferno::TestGroup
    id :c4bb_practitioner
    title 'Practitioner'

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@186'

    test from: :carin_server_requirement_186_attestation
  end
end
