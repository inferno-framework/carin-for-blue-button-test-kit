require 'inferno/dsl/oauth_credentials'
require_relative 'endpoints/submit_claims_endpoint'
require_relative 'endpoints/token_endpoint'
require_relative 'endpoints/next_page_endpoint'
require_relative 'endpoints/resource_id_endpoint'

require_relative 'urls'
require_relative 'mock_server'
require_relative 'tags'
require_relative 'collection'
require_relative 'client_validation_test'

require_relative 'claim_data_request_tests/initial_wait_test'
require_relative 'initial_scratch_storing'
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

require_relative 'required_searches_tests/initial_wait_test'
require_relative 'required_searches_tests/patient_required_searches'
require_relative 'required_searches_tests/coverage_required_searches'
require_relative 'required_searches_tests/organization_required_searches'
require_relative 'required_searches_tests/practitioner_required_searches'
require_relative 'required_searches_tests/relatedperson_required_searches'
require_relative 'required_searches_tests/eob_required_searches'

require_relative 'claim_data_request_tests/client_claims_data_attestation_test'

module CarinForBlueButtonTestKit
  class C4BBV200ClientSuite < Inferno::TestSuite
    extend MockServer
    extend ClientValidationTest

    id :c4bb_v200_client
    title 'Carin For Blue Button® v2.0.0 Client Test Suite'
    description %(
      The CARIN for Blue Button test suite validates system conformance to the HL7® FHIR®
      [CARIN for Blue Button® Implementation Guide](http://hl7.org/fhir/us/carin-bb/STU2).
    )

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

    suite_endpoint :post, TOKEN_PATH, TokenEndpoint

    suite_endpoint :get, PATIENT_PATH, SubmitClaimsEndpoint

    suite_endpoint :get, SUBMIT_PATH, SubmitClaimsEndpoint

    suite_endpoint :get, RESOURCE_ID_PATH, ResourceIDEndpoint

    suite_endpoint :get, BASE_FHIR_PATH, NextPageEndpoint

    resume_test_route :get, RESUME_PASS_PATH do |request|
      C4BBV200ClientSuite.extract_token_from_query_params(request)
    end

    resume_test_route :get, RESUME_CLAIMS_DATA_PATH do |request|
      C4BBV200ClientSuite.extract_token_from_query_params(request)
    end

    resume_test_route :get, RESUME_FAIL_PATH, result: 'fail' do |request|
      C4BBV200ClientSuite.extract_token_from_query_params(request)
    end

    route(:get, METADATA_PATH, get_metadata)

    group do
      run_as_group
      title 'Carin For Blue Button claims data request tests'
      test from: :initial_wait_test
      test from: :initial_scratch_storing
      test from: :patient_claims_data_request_test
      test from: :coverage_claims_data_request_test
      test from: :organization_claims_data_request_test
      test from: :practitioner_claims_data_request_test
      test from: :relatedperson_claims_data_request_test
      test from: :eob_inpatient_claims_data_request_test
      test from: :eob_outpatient_claims_data_request_test
      test from: :eob_oral_claims_data_request_test
      test from: :eob_pharmacy_claims_data_request_test
      test from: :eob_professional_claims_data_request_test
      test from: :client_claims_data_attestation
    end

    group do
      run_as_group
      title 'Carin For Blue Button required search tests'
      test from: :initial_wait_test_required_searches
      test from: :initial_scratch_storing
      test from: :patient_required_searches
      test from: :coverage_required_searches
      test from: :organization_required_searches
      test from: :practitioner_required_searches
      test from: :relatedperson_required_searches
      test from: :eob_required_searches
    end
  end
end
