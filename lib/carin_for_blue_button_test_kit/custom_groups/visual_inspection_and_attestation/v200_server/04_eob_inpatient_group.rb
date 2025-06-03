# frozen_string_literal: true

require_relative '04_eob_inpatient_group/attestation_test_requirement_130'
require_relative '04_eob_inpatient_group/attestation_test_requirement_132'

module CarinForBlueButtonTestKit
  class CarinEOBInpatientAttestationGroup < Inferno::TestGroup
    id :c4bb_eob_inpatient
    title 'Explanation of Benefit - Inpatient Institutional'
    short_title 'EOB Inpatient Institutional'

    test from: :carin_server_requirement_130_attestation
    test from: :carin_server_requirement_132_attestation
  end
end
