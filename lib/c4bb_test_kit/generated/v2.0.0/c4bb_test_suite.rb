require 'inferno/dsl/oauth_credentials'
require 'smart_app_launch_test_kit'
require_relative '../../version'

require_relative '../../capability_statement/capability_statement_group'
require_relative '../../custom_groups/v2.0.0/c4bb_smart_launch_group'

require_relative 'patient_group'
require_relative 'explanation_of_benefit_group'
require_relative 'explanation_of_benefit_inpatient_institutional_group'
require_relative 'explanation_of_benefit_outpatient_institutional_group'
require_relative 'explanation_of_benefit_oral_group'
require_relative 'explanation_of_benefit_pharmacy_group'
require_relative 'explanation_of_benefit_professional_non_clinician_group'
require_relative 'coverage_group'
require_relative 'organization_group'
require_relative 'practitioner_group'
require_relative 'related_person_group'

module C4BBTestKit
  module CARIN4BBV200
    class C4BBTestSuite < Inferno::TestSuite
      title 'CARIN IG for Blue Button® v2.0.0'
      description %(
        The CARIN for Blue Button test suite validates system conformance to the HL7® FHIR® [CARIN for Blue Button® Implementation Guide](http://hl7.org/fhir/us/carin-bb/STU2).

        
      )
      version VERSION
      links [
        {
          label: 'Open Source',
          url: 'https://github.com/inferno-framework/cc4bb-test-kit'
        },
        {
          label: 'Implementation Guide',
          url: 'http://hl7.org/fhir/us/carin-bb/STU2'
        }
      ]

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

      fhir_client do
        url :url
        oauth_credentials :smart_credentials
      end

      group from: :c4bb_v200_smart_launch

      group do
        title 'C4BB FHIR API Tests'
        description %(
          The CARIN for Blue Button FHIR API Tests evaluate the ability of a system (C4BB FHIR Server)
          to support required and optional FHIR operations and search parameters to return
          conformant C4BB resources.
        )

        group from: :capability_statement_group
    
        group from: :c4bb_v200_patient
        group from: :c4bb_v200_explanation_of_benefit
        group from: :c4bb_v200_explanation_of_benefit_inpatient_institutional
        group from: :c4bb_v200_explanation_of_benefit_outpatient_institutional
        group from: :c4bb_v200_explanation_of_benefit_oral
        group from: :c4bb_v200_explanation_of_benefit_pharmacy
        group from: :c4bb_v200_explanation_of_benefit_professional_non_clinician
        group from: :c4bb_v200_coverage
        group from: :c4bb_v200_organization
        group from: :c4bb_v200_practitioner
        group from: :c4bb_v200_related_person
      end
    end
  end
end
