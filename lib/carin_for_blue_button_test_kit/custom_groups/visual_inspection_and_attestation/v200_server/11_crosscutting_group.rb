require_relative '11_crosscutting_group/adjudication_amount'
require_relative '11_crosscutting_group/amount_calculations'
require_relative '11_crosscutting_group/coverage_reference_resource'
require_relative '11_crosscutting_group/meta_lastupdated'

module CarinForBlueButtonTestKit
  class CarinCrossCuttingAttestationGroup < Inferno::TestGroup
    id :c4bb_crosscutting
    title 'Cross Cutting'

    verifies_requirements 'hl7.fhir.us.carin-bb_2.0.0@186'

    test from: :coverage_reference_resource
    test from: :amount_calculations
    test from: :adjudication_amount
    test from: :meta_last_updated
  end
end
