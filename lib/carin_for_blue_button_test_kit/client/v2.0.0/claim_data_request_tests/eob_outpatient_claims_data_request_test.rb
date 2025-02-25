require_relative '../urls'
require_relative '../client_validation_test'

module CarinForBlueButtonTestKit
  class C4BBClientEOBOutpatientSubmitClaimsDataRequestTest < Inferno::Test
    include URLs
    include CarinForBlueButtonTestKit::ClientValidationTest

    id :eob_outpatient_claims_data_request_test
    title 'Outpatient Institutional ExplanationOfBenefit resources related to CARIN claims data are gathered'
    description %(
      This test verifies that an instance returned by requests made by the client is an ExplanationOfBenefit resource
      that conforms to the CARIN for Blue Button [Outpatient Institutional ExplanationOfBenefit profile](https://hl7.org/fhir/us/carin-bb/STU2/StructureDefinition-C4BB-ExplanationOfBenefit-Outpatient-Institutional.html).
    )

    run do
      resources = previous_resource_requests(:ExplanationOfBenefit_Outpatient_Institutional)
      skip_if resources.nil?,
              'No requests made for ExplanationOfBenefit resources'

      assert resources.any? { |resource|
        resource.id == 'c4bb-EOBOutpatient'
      },
             'Unable to find expected resource: c4bb-EOBOutpatient'
    end
  end
end
