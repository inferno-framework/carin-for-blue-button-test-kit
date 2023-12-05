require 'inferno/dsl/oauth_credentials'
require 'smart_app_launch_test_kit'
require_relative '../../version'

require_relative '../../capability_statement/capability_statement_group'
require_relative '../../custom_groups/v1.1.0/c4bb_smart_launch_group'

require_relative 'patient_group'
require_relative 'eob_group'
require_relative 'coverage_group'
require_relative 'organization_group'
require_relative 'practitioner_group'

module CarinForBlueButtonTestKit
  module CARIN4BBV110
    class C4BBTestSuite < Inferno::TestSuite
      title 'CARIN IG for Blue Button® v1.1.0'
      description %(
        The CARIN for Blue Button test suite validates system conformance to the HL7® FHIR® [CARIN for Blue Button® Implementation Guide](http://hl7.org/fhir/us/carin-bb/STU1.1).

        
      )
      version VERSION
      links [
        {
          label: 'Open Source',
          url: 'https://github.com/inferno-framework/carin-for-blue-button-test-kit'
        },
        {
          label: 'Implementation Guide',
          url: 'http://hl7.org/fhir/us/carin-bb/STU1.1'
        }
      ]

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

      fhir_client do
        url :url
        oauth_credentials :smart_credentials
      end

      group from: :c4bb_v110_smart_launch

      group do
        title 'C4BB FHIR API Tests'
        description %(
          The CARIN for Blue Button FHIR API Tests evaluate the ability of a system (C4BB FHIR Server)
          to support required and optional FHIR operations and search parameters to return
          conformant C4BB resources.
        )

        group from: :capability_statement_group
    
        group from: :c4bb_v110_patient
        group from: :c4bb_v110_eob
        group from: :c4bb_v110_coverage
        group from: :c4bb_v110_organization
        group from: :c4bb_v110_practitioner
      end
    end
  end
end
