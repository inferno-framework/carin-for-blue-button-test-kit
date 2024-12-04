require 'inferno/dsl/oauth_credentials'
require_relative 'endpoints/resource_api_endpoint'
require_relative 'endpoints/token_endpoint'
require_relative 'endpoints/next_page_endpoint'
require_relative 'endpoints/resource_id_endpoint'

require_relative 'urls'
require_relative 'mock_server'
require_relative 'tags'
require_relative 'collection'
require_relative 'client_validation_test'

require_relative 'initial_wait_test'

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

module CarinForBlueButtonTestKit
  class C4BBV200ClientSuite < Inferno::TestSuite
    extend MockServer
    extend ClientValidationTest

    id :c4bb_v200_client
    title 'Carin For Blue Button® v2.0.0 Client Test Suite'
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

    suite_endpoint :post, TOKEN_PATH, TokenEndpoint

    suite_endpoint :get, PATIENT_PATH, ResourceAPIEndpoint

    suite_endpoint :get, RESOURCE_API_PATH, ResourceAPIEndpoint

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
      title 'Wait for Claims Data and Search Requests'
      description %(
        This test will wait for the client system under test to submit requests for resources for each Carin for Blue
        Button profiles, and for requests including all of the required search parameters for each resource type.
      )

      test from: :initial_wait_test
    end

    group do
      title 'C4BB Patient Profile claims data and search request tests'
      description %(
        These tests look through all the requests sent in from the client system to ensure a request was made that
        returned the Patient resource implementing the Carin for Blue Button Patient profile from the Inferno
        Reference Server. It will also verify that each required search Parameter for the Patient resource specified
        in the Carin for Blue Button IG and the US Core 3.1.1 IG  was used in requests made by the client.
      )

      test from: :patient_claims_data_request_test
      test from: :patient_required_searches
    end

    group do
      title 'C4BB Coverage Profile claims data and search request tests'
      description %(
        These tests look through all the requests sent in from the client system to ensure a request was made that
        returned the Coverage resource implementing the Carin for Blue Button Coverage profile from the Inferno
        Reference Server. It will also verify that each required search Parameter for the Coverage resource specified
        in the Carin for Blue Button IG and the US Core 3.1.1 IG  was used in requests made by the client.
      )

      test from: :coverage_claims_data_request_test
      test from: :coverage_required_searches
    end

    group do
      title 'C4BB Organization Profile claims data and search request tests'
      description %(
        These tests look through all the requests sent in from the client system to ensure a request was made that
        returned the Organization resource implementing the Carin for Blue Button Organization profile from the Inferno
        Reference Server. It will also verify that each required search Parameter for the Organization resource
        specified in the Carin for Blue Button IG and the US Core 3.1.1 IG  was used in requests made by the client.
      )

      test from: :organization_claims_data_request_test
      test from: :organization_required_searches
    end

    group do
      title 'C4BB Practitioner Profile claims data and search request tests'
      description %(
        These tests look through all the requests sent in from the client system to ensure a request was made that
        returned the Practitioner resource implementing the Carin for Blue Button Practitioner profile from the Inferno
        Reference Server. It will also verify that each required search Parameter for the Practitioner resource
        specified in the Carin for Blue Button IG and the US Core 3.1.1 IG  was used in requests made by the client.
      )

      test from: :practitioner_claims_data_request_test
      test from: :practitioner_required_searches
    end

    group do
      title 'C4BB RelatedPerson Profile claims data and search request tests'
      description %(
        These tests look through all the requests sent in from the client system to ensure a request was made that
        returned the RelatedPerson resource implementing the Carin for Blue Button RelatedPerson profile from the
        Inferno Reference Server. It will also verify that each required search Parameter for the RelatedPerson resource
        specified in the Carin for Blue Button IG and the US Core 3.1.1 IG  was used in requests made by the client.
      )

      test from: :relatedperson_claims_data_request_test
      test from: :relatedperson_required_searches
    end

    group do
      title 'C4BB ExplanationOfBenefit Profiles claims data and search request tests'
      description %(
        These tests look through all the requests sent in from the client system to ensure a request was made that
        returned the ExplanationOfBenefit resources implementing each of the Carin for Blue Button ExplanationOfBenefit
        profiles from the Inferno Reference Server. It will also verify that each required search Parameter for the
        ExplanationOfBenefit resource specified in the Carin for Blue Button IG and the US Core 3.1.1 IG  was used in
        requests made by the client.
      )

      test from: :eob_inpatient_claims_data_request_test
      test from: :eob_outpatient_claims_data_request_test
      test from: :eob_oral_claims_data_request_test
      test from: :eob_pharmacy_claims_data_request_test
      test from: :eob_professional_claims_data_request_test
      test from: :eob_required_searches
    end

    group do
      run_as_group
      title 'Carin For Blue Button Client Attestation'
      description %(
        Attest that the client system under test was able to sucessfully process all of the requested resources for
        each of the Carin for Blue Button profiles.
      )

      test from: :client_claims_data_attestation
    end
  end
end
