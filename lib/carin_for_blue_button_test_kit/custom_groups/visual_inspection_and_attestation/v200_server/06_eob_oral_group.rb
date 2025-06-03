# frozen_string_literal: true

require_relative '06_eob_oral_group/attestation_test_requirement_144'
require_relative '06_eob_oral_group/attestation_test_requirement_148'
require_relative '06_eob_oral_group/attestation_test_requirement_149'
require_relative '06_eob_oral_group/attestation_test_requirement_150'
require_relative '06_eob_oral_group/attestation_test_requirement_151'
require_relative '06_eob_oral_group/attestation_test_requirement_152'
require_relative '06_eob_oral_group/attestation_test_requirement_153'

module CarinForBlueButtonTestKit
  class CarinEOBOralAttestationGroup < Inferno::TestGroup
    id :c4bb_eob_oral
    title 'Explanation of Benefit - Oral'
    short_title 'EOB Oral'

    test from: :carin_server_requirement_144_145_146_attestation
    test from: :carin_server_requirement_148_attestation
    test from: :carin_server_requirement_149_attestation
    test from: :carin_server_requirement_150_attestation
    test from: :carin_server_requirement_151_attestation
    test from: :carin_server_requirement_152_attestation
    test from: :carin_server_requirement_153_attestation
  end
end
