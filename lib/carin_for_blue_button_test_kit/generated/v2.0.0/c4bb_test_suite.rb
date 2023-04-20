require 'inferno/dsl/oauth_credentials'
require 'smart_app_launch_test_kit'
require_relative '../../version'

require_relative '../../capability_statement/capability_statement_group'

require_relative 'patient_group'
require_relative 'coverage_group'
require_relative 'explanation_of_benefit_group'
require_relative 'explanation_of_benefit_inpatient_institutional_group'
require_relative 'explanation_of_benefit_outpatient_institutional_group'
require_relative 'explanation_of_benefit_oral_group'
require_relative 'explanation_of_benefit_pharmacy_group'
require_relative 'explanation_of_benefit_professional_non_clinician_group'
require_relative 'organization_group'
require_relative 'practitioner_group'
require_relative 'related_person_group'

module CarinForBlueButtonTestKit
  module CARIN4BBV200
    class C4BBTestKit < Inferno::TestSuite
      title 'CARIN for Blue Button v2.0.0'
      version VERSION

      def self.metadata
        @metadata ||= YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true)[:groups].map do |raw_metadata|
            Generator::GroupMetadata.new(raw_metadata)
          end
      end

      validator do
        url ENV.fetch('V200_VALIDATOR_URL', 'http://validator_service:4567')
      end

      id :c4bb_v200

      input :url,
        title: 'FHIR Endpoint',
        description: 'URL of the FHIR endpoint'
      input :smart_credentials,
        title: 'OAuth Credentials',
        type: :oauth_credentials,
        optional: true

      # SMART Test Suite requirement
      group from: :smart_discovery
      group from: :smart_standalone_launch,
        config: {
          outputs: {
            patient_id: {
              name: :patient_ids
            }
          }
        }

      fhir_client do
        url :url
        oauth_credentials :smart_credentials
      end

      group from: :capability_statement_group
  
      group from: :c4bb_v200_patient
      group from: :c4bb_v200_coverage
      group from: :c4bb_v200_explanation_of_benefit
      group from: :c4bb_v200_explanation_of_benefit_inpatient_institutional
      group from: :c4bb_v200_explanation_of_benefit_outpatient_institutional
      group from: :c4bb_v200_explanation_of_benefit_oral
      group from: :c4bb_v200_explanation_of_benefit_pharmacy
      group from: :c4bb_v200_explanation_of_benefit_professional_non_clinician
      group from: :c4bb_v200_organization
      group from: :c4bb_v200_practitioner
      group from: :c4bb_v200_related_person
    end
  end
end
