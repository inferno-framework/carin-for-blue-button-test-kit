require_relative '../client_validation_test'
require_relative '../tags'
module CarinForBlueButtonTestKit
  class Carin4BBClientScratchStorage < Inferno::Test
    include CarinForBlueButtonTestKit::ClientValidationTest

    id :initial_scratch_storing
    title 'Client makes claim data requests that capture an entire patient'
    description %(
      This test organizes the received requests in order to validate all expected specific resources were returned
    )
    input :access_token

    def extract_eob_profile(resource)
      profile_url = resource.meta.profile.find do |profile|
        profile.include?('StructureDefinition/C4BB-ExplanationOfBenefit')
      end
      match = %r{http://hl7.org/fhir/us/carin-bb/StructureDefinition/(.*)}.match(profile_url)
      return unless match.present?

      match[1].delete_prefix('C4BB-ExplanationOfBenefit-').split('|')[0].gsub('-', '_')
    end

    run do
      previous_claims_data_request_resources.each do |request, resources|
        resources.each do |resource|
          if resource.resourceType == 'ExplanationOfBenefit'
            profile = extract_eob_profile(resource)
            identifier = "#{resource.resourceType}_#{profile}"
            scratch[identifier.to_sym] ||= []
            scratch[identifier.to_sym] |= [resource]
          end
          scratch[resource.resourceType.to_sym] ||= []
          scratch[resource.resourceType.to_sym] |= [resource]
        end
      end
    end
  end
end
