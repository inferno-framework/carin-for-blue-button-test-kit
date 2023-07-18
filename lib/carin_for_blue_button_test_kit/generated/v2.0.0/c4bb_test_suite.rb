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
      title 'CARIN IG for Blue Button® v2.0.0'
      description %(
        The CARIN for Blue Button test suite validates system conformance to the HL7® FHIR® [CARIN for Blue Button® Implementation Guide](http://hl7.org/fhir/us/carin-bb/STU2).

        
      )
      version VERSION
      links [
        {
          label: 'Open Source',
          url: 'https://github.com/inferno-framework/carin-for-blue-button-test-kit'
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
      input :smart_credentials,
        title: 'OAuth Credentials',
        type: :oauth_credentials,
        optional: true

      # SMART Test Suite requirement
      group from: :smart_discovery,
        run_as_group: true
      group from: :smart_standalone_launch,
        run_as_group: true,
        config: {
          outputs: {
            patient_id: { name: :patient_ids },
            smart_credentials: { name: :smart_credentials }
          }
        },
        description: %(
          # Background

          The [Standalone
          Launch Sequence](https://www.hl7.org/fhir/smart-app-launch/1.0.0/index.html#standalone-launch-sequence)
          allows an app, like Inferno, to be launched independent of an
          existing EHR session. It is one of the two launch methods described in
          the SMART App Launch Framework alongside EHR Launch. The app will
          request authorization for the provided scope from the authorization
          endpoint, ultimately receiving an authorization token which can be used
          to gain access to resources on the FHIR server.

          # Test Methodology

          Inferno will redirect the user to the authorization endpoint so that
          they can provide any required credentials and authorize the application.
          Upon successful authorization, Inferno will exchange the authorization
          code provided for an access token.

          For more information on the #{title}:

          * [Standalone Launch Sequence](https://www.hl7.org/fhir/smart-app-launch/1.0.0/index.html#standalone-launch-sequence)
        )

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
