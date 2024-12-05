require_relative '../urls'
require_relative '../client_validation_test'

module CarinForBlueButtonTestKit
  class C4BBClientPatientSubmitClaimsDataRequestTest < Inferno::Test
    include URLs
    include CarinForBlueButtonTestKit::ClientValidationTest

    id :patient_claims_data_request_test
    title 'Patient resources related to the patient matched are gathered'
    description %(
      This test will look through all returned Patient resources for a specific expected Patient
      resource that supports the CARIN for Blue Button [Patient profile](https://hl7.org/fhir/us/carin-bb/STU2/StructureDefinition-C4BB-Patient.html)
      on the Inferno Reference Server.
    )
    input :access_token

    run do
      resources = previous_resource_requests(:Patient)
      skip_if resources.nil?, 'No requests made for Patient resources'

      assert resources.any? { |resource| resource.id == '888' }, 'Unable to find expected resource: 888'
    end
  end
end
