# frozen_string_literal: true

module CarinForBlueButtonTestKit
  TOKEN_PATH = '/auth/token'
  AUTHORIZATION_PATH = '/auth/authorization'
  JKWS_PATH = '/.well-known/jwks.json'
  SMART_CONFIG_PATH = '/.well-known/smart-configuration'
  PATIENT_PATH = '/fhir/Patient'
  RESOURCE_API_PATH = '/fhir/:endpoint'
  RESOURCE_ID_PATH = '/fhir/:endpoint/:id'
  METADATA_PATH = '/fhir/metadata'
  BASE_FHIR_PATH = '/fhir'
  RESUME_PASS_PATH = '/resume_pass'
  RESUME_CLAIMS_DATA_PATH = '/resume_claims_data'
  RESUME_FAIL_PATH = '/resume_fail'

  module URLs
    def base_url
      @base_url ||= "#{Inferno::Application['base_url']}/custom/#{suite_id}"
    end

    def token_url
      @token_url ||= base_url + TOKEN_PATH
    end

    def authorization_url
      @authorization_url ||= base_url + AUTHORIZATION_PATH
    end

    def jwks_url
      @jwks_url ||= base_url + JKWS_PATH
    end

    def smart_configuration_url
      @smart_configuration_url ||= base_url + SMART_CONFIG_PATH
    end

    def fhir_base_url
      @fhir_base_url ||= base_url + BASE_FHIR_PATH
    end

    # alias for OIDC from SMART / UDAP client tests
    def client_fhir_base_url
      fhir_base_url
    end

    def patient_url
      @patient_url ||= base_url + PATIENT_PATH
    end

    def resource_api_url
      @resource_api_url ||= base_url + RESOURCE_API_PATH
    end

    def resource_id_url
      @resource_id_url ||= base_url + RESOURCE_ID_PATH
    end

    def metadata_url
      @metadata_url ||= base_url + METADATA_PATH
    end

    def resume_pass_url
      @resume_pass_url ||= base_url + RESUME_PASS_PATH
    end

    def resume_claims_data_url
      @resume_claims_data_url ||= base_url + RESUME_CLAIMS_DATA_PATH
    end

    def resume_fail_url
      @resume_fail_url ||= base_url + RESUME_FAIL_PATH
    end

    def suite_id
      CarinForBlueButtonTestKit::C4BBV200ClientSuite.id
    end
  end
end
