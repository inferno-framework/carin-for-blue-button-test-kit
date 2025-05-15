require_relative 'v200_client/must_support_process'
require_relative 'v200_client/must_support_retain'
require_relative 'v200_client/must_support_missing'
require_relative 'v200_client/must_support_absent_reason'
require_relative 'v200_client/last_updated'

module CarinForBlueButtonTestKit
  class CarinClientVisualInspectionAndAttestationGroup < Inferno::TestGroup
    id :c4bb_client_v200_visual_inspection_and_attestation

    title 'Visual Inspection and Attestation'

    description <<~DESCRIPTION
      Perform visual inspections or attestations to ensure that the Client is conformant to the CARIN for Blue Button® IG requirements.
    DESCRIPTION

    run_as_group

    test from: :c4bb_must_support_process
    test from: :c4bb_must_support_retain
    test from: :c4bb_must_support_missing
    test from: :c4bb_must_support_absent_reason
    test from: :c4bb_last_updated
  end
end
