require 'inferno/dsl/oauth_credentials'
require_relative 'ext/inferno_core/record_response_route'
require_relative 'ext/inferno_core/runnable'
require_relative 'ext/inferno_core/request'
require_relative 'urls'
require_relative 'mock_server'
require_relative 'tags'
require_relative 'collection'
require_relative 'client_validation_test'

require_relative 'claim_data_request_tests/initial_scratch_storing'
require_relative 'claim_data_request_tests/initial_wait_test'
require_relative 'claim_data_request_tests/patient_claims_data_request_test'
require_relative 'claim_data_request_tests/client_claims_data_attestation_test'

module CarinForBlueButtonTestKit
  class CarinForBlueButtonClientSuite < Inferno::TestSuite
    extend MockServer
    extend ClientValidationTest

    id :c4bb_client
    title 'Carin For Blue Button Client Test Suite'
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

    record_response_route :post, TOKEN_PATH, AUTH_TAG, method(:token_response) do |request|
      CarinForBlueButtonClientSuite.extract_client_id(request)
    end

    record_response_route :get, PATIENT_PATH, SUBMIT_TAG, method(:carin_resource_response), # Patient needs a specific definition
                          resumes: method(:test_resumes?) do |request|
      CarinForBlueButtonClientSuite.extract_bearer_token(request)
    end

    record_response_route :get, SUBMIT_PATH, SUBMIT_TAG, method(:carin_resource_response),
                          resumes: method(:test_resumes?) do |request|
      CarinForBlueButtonClientSuite.extract_bearer_token(request)
    end

    resume_test_route :get, RESUME_PASS_PATH do |request|
      CarinForBlueButtonClientSuite.extract_token_from_query_params(request)
    end

    resume_test_route :get, RESUME_CLAIMS_DATA_PATH do |request|
      CarinForBlueButtonClientSuite.extract_token_from_query_params(request)
    end

    resume_test_route :get, RESUME_FAIL_PATH, result: 'fail' do |request|
      CarinForBlueButtonClientSuite.extract_token_from_query_params(request)
    end

    route(:get, METADATA_PATH, get_metadata)

    group do
      run_as_group
      title 'Carin For Blue Button data request tests'
      test from: :initial_wait_test
      test from: :initial_scratch_storing
      test from: :patient_claims_data_request_test
      test from: :client_claims_data_attestation
    end
  end
end
