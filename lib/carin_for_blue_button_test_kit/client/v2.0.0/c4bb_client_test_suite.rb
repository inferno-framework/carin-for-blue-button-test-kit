# frozen_string_literal: true

require_relative 'endpoints/resource_api_endpoint'
require_relative 'endpoints/token_endpoint'
require_relative 'endpoints/authorization_endpoint'
require_relative 'endpoints/next_page_endpoint'
require_relative 'endpoints/resource_id_endpoint'

require_relative 'urls'
require_relative 'mock_server'
require_relative 'tags'
require_relative 'collection'
require_relative 'client_validation_test'
require_relative 'client_options'

require_relative 'client_registration_group'
require_relative 'initial_wait_test'
require_relative 'client_auth_smart_alca_group'
require_relative 'client_auth_smart_alcs_group'
require_relative 'client_auth_smart_alp_group'
require_relative 'client_auth_udap_group'

require_relative 'claim_data_request_tests/patient_claims_data_request_test'
require_relative 'claim_data_request_tests/coverage_claims_data_request_test'
require_relative 'claim_data_request_tests/organization_claims_data_request_test'
require_relative 'claim_data_request_tests/practitioner_claims_data_request_test'
require_relative 'claim_data_request_tests/relatedperson_claims_data_request_test'
require_relative 'claim_data_request_tests/eob_inpatient_claims_data_request_test'
require_relative 'claim_data_request_tests/eob_outpatient_claims_data_request_test'
require_relative 'claim_data_request_tests/eob_oral_claims_data_request_test'
require_relative 'claim_data_request_tests/eob_pharmacy_claims_data_request_test'
require_relative 'claim_data_request_tests/eob_professional_claims_data_request_test'

require_relative 'required_searches_tests/patient_required_searches'
require_relative 'required_searches_tests/coverage_required_searches'
require_relative 'required_searches_tests/organization_required_searches'
require_relative 'required_searches_tests/practitioner_required_searches'
require_relative 'required_searches_tests/relatedperson_required_searches'
require_relative 'required_searches_tests/eob_required_searches'

require_relative 'claim_data_request_tests/client_claims_data_attestation_test'

require_relative '../../custom_groups/visual_inspection_and_attestation/v200_client'

module CarinForBlueButtonTestKit
  class C4BBV200ClientSuite < Inferno::TestSuite
    extend MockServer
    extend ClientValidationTest

    id :c4bb_v200_client
    title 'CARIN IG for Blue Button® v2.0.0 Client Test Suite'
    description File.read(File.join(__dir__, '..', '..', 'docs',
                                    'carin_for_blue_button_v2.0.0_client_suite_description.md'))

    def self.test_resumes?(test)
      !test.config.options[:accepts_multiple_requests]
    end

    links [
      {
        label: 'Report Issue',
        url: 'https://github.com/inferno-framework/carin-for-blue-button-test-kit/issues'
      },
      {
        label: 'Open Source',
        url: 'https://github.com/inferno-framework/carin-for-blue-button-test-kit'
      },
      {
        label: 'Download',
        url: 'https://github.com/inferno-framework/carin-for-blue-button-test-kit/releases'
      },
      {
        label: 'Implementation Guide',
        url: 'http://hl7.org/fhir/us/carin-bb/STU2'
      }
    ]

    VALIDATION_MESSAGE_FILTERS = [
      /\A\S+: \S+: URL value '.*' does not resolve/
    ].freeze

    fhir_resource_validator do
      igs 'igs/carin4bb-200.tgz'

      exclude_message do |message|
        VALIDATION_MESSAGE_FILTERS.any? { |filter| filter.match? message.message }
      end
    end

    suite_option  :client_type,
                  title: 'Client Security Type',
                  list_options: [
                    {
                      label: 'SMART App Launch Public Client',
                      value: CarinClientOptions::SMART_APP_LAUNCH_PUBLIC
                    },
                    {
                      label: 'SMART App Launch Confidential Symmetric Client',
                      value: CarinClientOptions::SMART_APP_LAUNCH_CONFIDENTIAL_SYMMETRIC
                    },
                    {
                      label: 'SMART App Launch Confidential Asymmetric Client',
                      value: CarinClientOptions::SMART_APP_LAUNCH_CONFIDENTIAL_ASYMMETRIC
                    },
                    {
                      label: 'UDAP Authorization Code Client',
                      value: CarinClientOptions::UDAP_AUTHORIZATION_CODE
                    }
                  ]

    route(:get, METADATA_PATH, get_metadata)
    route(:get, UDAPSecurityTestKit::UDAP_DISCOVERY_PATH, lambda { |_env|
      UDAPSecurityTestKit::MockUDAPServer.udap_server_metadata(id)
    })
    route(:get, SMARTAppLaunch::SMART_DISCOVERY_PATH, lambda { |_env|
      SMARTAppLaunch::MockSMARTServer.smart_server_metadata(id)
    })
    route(:get, SMARTAppLaunch::OIDC_DISCOVERY_PATH, lambda { |_env|
      SMARTAppLaunch::MockSMARTServer.openid_connect_metadata(id)
    })
    route(
      :get,
      SMARTAppLaunch::OIDC_JWKS_PATH,
      ->(_env) { [200, { 'Content-Type' => 'application/json' }, [SMARTAppLaunch::OIDCJWKS.jwks_json]] }
    )

    suite_endpoint :post, UDAPSecurityTestKit::REGISTRATION_PATH,
                   UDAPSecurityTestKit::MockUDAPServer::RegistrationEndpoint
    suite_endpoint :post, UDAPSecurityTestKit::TOKEN_PATH, MockUdapSmartServer::TokenEndpoint
    suite_endpoint :get,  UDAPSecurityTestKit::AUTHORIZATION_PATH, MockUdapSmartServer::AuthorizationEndpoint
    suite_endpoint :post, UDAPSecurityTestKit::AUTHORIZATION_PATH, MockUdapSmartServer::AuthorizationEndpoint

    suite_endpoint :get, PATIENT_PATH, ResourceAPIEndpoint
    suite_endpoint :get, RESOURCE_API_PATH, ResourceAPIEndpoint
    suite_endpoint :get, RESOURCE_ID_PATH, ResourceIDEndpoint
    suite_endpoint :get, BASE_FHIR_PATH, NextPageEndpoint

    resume_test_route :get, RESUME_CLAIMS_DATA_PATH do |request|
      C4BBV200ClientSuite.extract_test_run_identifier_from_query_params(request)
    end

    resume_test_route :get, RESUME_PASS_PATH do |request|
      C4BBV200ClientSuite.extract_token_from_query_params(request)
    end

    resume_test_route :get, RESUME_FAIL_PATH, result: 'fail' do |request|
      C4BBV200ClientSuite.extract_token_from_query_params(request)
    end

    group from: :c4bb_v200_client_registration

    group do
      title 'Verify CARIN for Blue Button Data Access'
      description %(
        During these tests, the client under tests will access data from Inferno's simulated
        CARIN for Blue Button server and then Inferno will check that the entire scope of
        the API defined by the IG has been used.
      )
      id :c4bb_data_access
      run_as_group

      group do
        title 'Wait for Claims Data and Search Requests'
        description %(
          This test will wait for the client system under test to submit requests for resources for each of the
          [CARIN for Blue Button profiles](https://hl7.org/fhir/us/carin-bb/STU2/artifacts.html#structures-resource-profiles),
          and for requests including all of the required search parameters for each resource type specified in the
          [C4BB CapabilityStatement](https://hl7.org/fhir/us/carin-bb/STU2/CapabilityStatement-c4bb.html) and the
          [US Core Client CapabilityStatement](https://hl7.org/fhir/us/core/STU3.1.1/CapabilityStatement-us-core-client.html).
        )
        id :c4bb_claims_data_wait_test_group

        test from: :c4bb_v200_initial_wait_test
      end

      group do
        title 'C4BB Patient Profile claims data and search request tests'
        description %(
          These tests look through all the requests sent in from the client system to ensure a request was made that
          returned a Patient resource implementing the CARIN for Blue Button [Patient profile](https://hl7.org/fhir/us/carin-bb/STU2/StructureDefinition-C4BB-Patient.html).
          It will also verify that the client made a request using each required search parameter for the Patient resource
          specified in the [CARIN IG for Blue Button](https://hl7.org/fhir/us/carin-bb/STU2/CapabilityStatement-c4bb.html#patient)
          and the [US Core Client](https://www.hl7.org/fhir/us/core/STU3.1.1/CapabilityStatement-us-core-client.html#patient)
          Capability Statements.
        )
        id :c4bb_patient_profile_test_group

        test from: :patient_claims_data_request_test
        test from: :patient_required_searches
      end

      group do
        title 'C4BB Coverage Profile claims data and search request tests'
        description %(
          These tests look through all the requests sent in from the client system to ensure a request was made that
          returned a Coverage resource implementing the CARIN for Blue Button [Coverage profile](https://hl7.org/fhir/us/carin-bb/STU2/StructureDefinition-C4BB-Coverage.html).
          It will also verify that the client made a request using each required search parameter for the Coverage
          resource specified in the [CARIN IG for Blue Button](https://hl7.org/fhir/us/carin-bb/STU2/CapabilityStatement-c4bb.html#coverage)
          and the [US Core Client](https://www.hl7.org/fhir/us/core/STU3.1.1/CapabilityStatement-us-core-client.html)
          Capability Statements.
        )
        id :c4bb_coverage_profile_test_group

        test from: :coverage_claims_data_request_test
        test from: :coverage_required_searches
      end

      group do
        title 'C4BB Organization Profile claims data and search request tests'
        description %(
          These tests look through all the requests sent in from the client system to ensure a request was made that
          returned a Organization resource implementing the CARIN for Blue Button [Organization profile](https://hl7.org/fhir/us/carin-bb/STU2/StructureDefinition-C4BB-Organization.html).
          It will also verify that the client made a request using each required search parameter for the Organization
          resource specified in the [CARIN IG for Blue Button](https://hl7.org/fhir/us/carin-bb/STU2/CapabilityStatement-c4bb.html#organization)
          and the [US Core Client](https://www.hl7.org/fhir/us/core/STU3.1.1/CapabilityStatement-us-core-client.html#organization)
          Capability Statements.
        )
        id :c4bb_organization_profile_test_group
        optional

        test from: :organization_claims_data_request_test
        test from: :organization_required_searches
      end

      group do
        title 'C4BB Practitioner Profile claims data and search request tests'
        description %(
          These tests look through all the requests sent in from the client system to ensure a request was made that
          returned a Practitioner resource implementing the CARIN for Blue Button [Practitioner profile](https://hl7.org/fhir/us/carin-bb/STU2/StructureDefinition-C4BB-Practitioner.html).
          It will also verify that the client made a request using each required search parameter for the Practitioner
          resource specified in the [CARIN IG for Blue Button](https://hl7.org/fhir/us/carin-bb/STU2/CapabilityStatement-c4bb.html#practitioner)
          and the [US Core Client](https://www.hl7.org/fhir/us/core/STU3.1.1/CapabilityStatement-us-core-client.html#practitioner)
          Capability Statements.
        )
        id :c4bb_practitioner_profile_test_group
        optional

        test from: :practitioner_claims_data_request_test
        test from: :practitioner_required_searches
      end

      group do
        title 'C4BB RelatedPerson Profile claims data and search request tests'
        description %(
          These tests look through all the requests sent in from the client system to ensure a request was made that
          returned a RelatedPerson resource implementing the CARIN for Blue Button [RelatedPerson profile](https://hl7.org/fhir/us/carin-bb/STU2/StructureDefinition-C4BB-RelatedPerson.html).
          It will also verify that the client made a request using each required search parameter for the RelatedPerson
          resource specified in the [CARIN IG for Blue Button](https://hl7.org/fhir/us/carin-bb/STU2/CapabilityStatement-c4bb.html#relatedperson)
          and the [US Core Client](https://www.hl7.org/fhir/us/core/STU3.1.1/CapabilityStatement-us-core-client.html)
          Capability Statements.
        )
        id :c4bb_relatedperson_profile_test_group
        optional

        test from: :relatedperson_claims_data_request_test
        test from: :relatedperson_required_searches
      end

      group do
        title 'C4BB ExplanationOfBenefit Profiles claims data and search request tests'
        description %(
          These tests look through all the requests sent in from the client system to ensure a request was made that
          returned ExplanationOfBenefit resources implementing each of the
          CARIN for Blue Button [ExplanationOfBenefit profiles](https://hl7.org/fhir/us/carin-bb/STU2/artifacts.html#structures-resource-profiles).
          It will also verify that the client made a request using each required search parameter for the
          ExplanationOfBenefit resource specified in the [CARIN IG for Blue Button](https://hl7.org/fhir/us/carin-bb/STU2/CapabilityStatement-c4bb.html#explanationofbenefit)
          and the [US Core Client](https://www.hl7.org/fhir/us/core/STU3.1.1/CapabilityStatement-us-core-client.html)
          Capability Statements.
        )
        id :c4bb_explanationofbenefit_profiles_test_group

        test from: :eob_inpatient_claims_data_request_test
        test from: :eob_outpatient_claims_data_request_test
        test from: :eob_oral_claims_data_request_test
        test from: :eob_pharmacy_claims_data_request_test
        test from: :eob_professional_claims_data_request_test
        test from: :eob_required_searches
      end

      group do
        run_as_group
        title 'CARIN For Blue Button Client Attestation'
        description %(
          Attest that the client system under test was able to sucessfully process all of the requested resources for
          each of the CARIN for Blue Button profiles.
        )
        id :c4bb_client_attestation_test_group

        test from: :client_claims_data_attestation
      end

      group from: :c4bb_v200_client_auth_smart_alca,
            required_suite_options: {
              client_type: CarinClientOptions::SMART_APP_LAUNCH_CONFIDENTIAL_ASYMMETRIC
            }
      group from: :c4bb_v200_client_auth_smart_alcs,
            required_suite_options: {
              client_type: CarinClientOptions::SMART_APP_LAUNCH_CONFIDENTIAL_SYMMETRIC
            }
      group from: :c4bb_v200_client_auth_smart_alp,
            required_suite_options: {
              client_type: CarinClientOptions::SMART_APP_LAUNCH_PUBLIC
            }
      group from: :c4bb_v200_client_auth_udap,
            required_suite_options: {
              client_type: CarinClientOptions::UDAP_AUTHORIZATION_CODE
            }
    end

    group from: :c4bb_client_v200_visual_inspection_and_attestation do
      optional
    end
  end
end
