require_relative '../client_validation_test'
module CarinForBlueButtonTestKit
  class Carin4BBClientScratchStorage < Inferno::Test
    include CarinForBlueButtonTestKit::ClientValidationTest

    id :initial_scratch_storing
    title 'Client makes claim data requests that capture an entire patient'
    description %(
      This test organizes the received requests in order to validate all expected specific resources were returned
    )
    input :access_token

    run do
      previous_claims_data_request_resources.each do |request, resources|
        resources.each do |resource|
          scratch[resource.resourceType.to_sym] ||= []
          scratch[resource.resourceType.to_sym] |= [resource]
        end
      end
    end
  end
end
