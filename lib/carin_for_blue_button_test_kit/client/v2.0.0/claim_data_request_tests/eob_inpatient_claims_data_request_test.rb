require_relative '../urls'
require_relative '../client_validation_test'

module CarinForBlueButtonTestKit
  class C4BBClientEOBInpatientSubmitClaimsDataRequestTest < Inferno::Test
    include URLs
    include CarinForBlueButtonTestKit::ClientValidationTest

    id :eob_inpatient_claims_data_request_test
    title 'Inpatient Institutional ExplanationOfBenefit resources related to CARIN claims data are gathered'
    description %(
      This test verifies that an instance returned by requests made by the client is an ExplanationOfBenefit resource
      that conforms to the CARIN for Blue Button [Outpatient Institutional ExplanationOfBenefit profile](https://hl7.org/fhir/us/carin-bb/STU2/StructureDefinition-C4BB-ExplanationOfBenefit-Outpatient-Institutional.html).
    )
    input :access_token

    run do
      resources = previous_resource_requests(:ExplanationOfBenefit_Inpatient_Institutional)
      skip_if resources.nil?,
              'No requests made for ExplanationOfBenefit resources'

      assert resources.any? { |resource| resource.id == 'c4bb-EOBInpatient' },
             'Unable to find expected resource: c4bb-EOBInpatient'
    end
  end
end
