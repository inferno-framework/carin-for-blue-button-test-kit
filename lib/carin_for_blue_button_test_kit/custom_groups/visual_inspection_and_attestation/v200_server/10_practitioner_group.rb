# frozen_string_literal: true

require_relative '10_practitioner_group/attestation_test_requirement_186'

module CarinForBlueButtonTestKit
  class CarinPractitionerAttestationGroup < Inferno::TestGroup
    id :c4bb_practitioner
    title 'Practitioner'

    test from: :carin_server_requirement_186_attestation
  end
end
