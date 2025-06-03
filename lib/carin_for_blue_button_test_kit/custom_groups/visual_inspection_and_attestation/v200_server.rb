# frozen_string_literal: true

require_relative 'v200_server/00_authorization_group'
require_relative 'v200_server/01_must_support_group'
require_relative 'v200_server/03_eob_group'
require_relative 'v200_server/04_eob_inpatient_group'
require_relative 'v200_server/05_eob_outpatient_group'
require_relative 'v200_server/06_eob_oral_group'
require_relative 'v200_server/07_eob_pharmacy_group'
require_relative 'v200_server/08_eob_nonclinician_group'
require_relative 'v200_server/09_organization_group'
require_relative 'v200_server/10_practitioner_group'
require_relative 'v200_server/11_crosscutting_group'

module CarinForBlueButtonTestKit
  class CarinServerVisualInspectionAndAttestationGroup < Inferno::TestGroup
    id :c4bb_server_v200_visual_inspection_and_attestation

    title 'Visual Inspection and Attestation'

    description <<~DESCRIPTION
      Perform visual inspections or attestations to ensure that the Server is conformant to the CARIN for Blue Button® IG requirements.
    DESCRIPTION

    run_as_group

    group from: :c4bb_security
    group from: :c4bb_must_support
    group from: :c4bb_eob
    group from: :c4bb_eob_inpatient
    group from: :c4bb_eob_outpatient
    group from: :c4bb_eob_oral
    group from: :c4bb_eob_pharmacy
    group from: :c4bb_eob_nonclinician
    group from: :c4bb_organization
    group from: :c4bb_practitioner
    group from: :c4bb_crosscutting
  end
end
