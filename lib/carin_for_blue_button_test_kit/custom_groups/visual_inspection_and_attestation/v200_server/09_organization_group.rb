require_relative '09_organization_group/attestation_test_requirement_177'
require_relative '09_organization_group/attestation_test_requirement_178'

module CarinForBlueButtonTestKit
  class CarinOrganizationAttestationGroup < Inferno::TestGroup
    id :c4bb_organization
    title 'Organization'

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@177',
                          'hl7.fhir.us.carin-bb_2.0.0@178'

    test from: :carin_server_requirement_177_attestation
    test from: :carin_server_requirement_178_attestation
  end
end
