# frozen_string_literal: true

require_relative '../urls'
require_relative '../client_validation_test'

module CarinForBlueButtonTestKit
  class C4BBClientEOBProfessionalSubmitClaimsDataRequestTest < Inferno::Test
    include URLs
    include CarinForBlueButtonTestKit::ClientValidationTest

    id :eob_professional_claims_data_request_test
    title 'Professional NonClinician ExplanationOfBenefit resources related to CARIN claims data are gathered'
    description %(
      This test verifies that an instance returned by requests made by the client is an ExplanationOfBenefit resource
      that conforms to the CARIN for Blue Button [Professional NonClinician ExplanationOfBenefit profile](https://hl7.org/fhir/us/carin-bb/STU2/StructureDefinition-C4BB-ExplanationOfBenefit-Professional-NonClinician.html).
    )

    run do
      resources = previous_resource_requests(:ExplanationOfBenefit_Professional_NonClinician)
      skip_if resources.nil?,
              'No requests made for ExplanationOfBenefit resources'

      assert resources.any? { |resource|
        resource.id == 'c4bb-EOBProfessional'
      }, 'Unable to find expected resource: c4bb-EOBProfessional'
    end
  end
end
