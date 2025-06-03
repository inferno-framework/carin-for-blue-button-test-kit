# frozen_string_literal: true

require_relative '09_organization_group/attestation_test_requirement_177'
require_relative '09_organization_group/attestation_test_requirement_178'

module CarinForBlueButtonTestKit
  class CarinOrganizationAttestationGroup < Inferno::TestGroup
    id :c4bb_organization
    title 'Organization'

    test from: :carin_server_requirement_177_attestation
    test from: :carin_server_requirement_178_attestation
  end
end
