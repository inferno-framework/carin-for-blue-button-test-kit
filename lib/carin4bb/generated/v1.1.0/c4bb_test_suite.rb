require 'inferno/dsl/oauth_credentials'
require_relative '../../version'

require_relative 'patient_group'
require_relative 'coverage_group'
require_relative 'explanation_of_benefit_group'
require_relative 'explanation_of_benefit_inpatient_institutional_group'
require_relative 'explanation_of_benefit_outpatient_institutional_group'
require_relative 'explanation_of_benefit_pharmacy_group'
require_relative 'explanation_of_benefit_professional_non_clinician_group'
require_relative 'organization_group'
require_relative 'practitioner_group'

module CARINForBlueButton
  module CARIN4BBV110
    class C4BBTestKit < Inferno::TestSuite
      title 'CARIN for Blue Button v1.1.0'
      version VERSION

      def self.metadata
        @metadata ||= YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true)[:groups].map do |raw_metadata|
            Generator::GroupMetadata.new(raw_metadata)
          end
      end

      validator do
        url ENV.fetch('V110_VALIDATOR_URL', 'http://validator_service:4567')
      end

      id :c4bb_v110

      input :url,
        title: 'FHIR Endpoint',
        description: 'URL of the FHIR endpoint'
      input :smart_credentials,
        title: 'OAuth Credentials',
        type: :oauth_credentials,
        optional: true

      fhir_client do
        url :url
        oauth_credentials :smart_credentials
      end

  
      group from: :c4bb_v110_patient
      group from: :c4bb_v110_coverage
      group from: :c4bb_v110_explanation_of_benefit
      group from: :c4bb_v110_explanation_of_benefit_inpatient_institutional
      group from: :c4bb_v110_explanation_of_benefit_outpatient_institutional
      group from: :c4bb_v110_explanation_of_benefit_pharmacy
      group from: :c4bb_v110_explanation_of_benefit_professional_non_clinician
      group from: :c4bb_v110_organization
      group from: :c4bb_v110_practitioner
    end
  end
end
