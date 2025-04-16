module CarinForBlueButtonTestKit
  SESSION_PATH_PLACEHOLDER = '/:session_path'
  TOKEN_PATH = '/auth/token'.freeze
  AUTHORIZATION_PATH = '/auth/authorization'.freeze
  JKWS_PATH = '/.well-known/jwks.json'.freeze
  SMART_CONFIG_PATH = '/.well-known/smart-configuration'.freeze
  PATIENT_PATH = '/fhir/Patient'.freeze
  SESSION_PATIENT_PATH = SESSION_PATH_PLACEHOLDER + PATIENT_PATH
  RESOURCE_API_PATH = '/fhir/:endpoint'.freeze
  SESSION_RESOURCE_API_PATH = SESSION_PATH_PLACEHOLDER + RESOURCE_API_PATH
  RESOURCE_ID_PATH = '/fhir/:endpoint/:id'.freeze
  SESSION_RESOURCE_ID_PATH = SESSION_PATH_PLACEHOLDER + RESOURCE_ID_PATH
  METADATA_PATH = '/fhir/metadata'.freeze
  SESSION_METADATA_PATH = SESSION_PATH_PLACEHOLDER + METADATA_PATH
  BASE_FHIR_PATH = '/fhir'.freeze
  SESSION_BASE_FHIR_PATH = SESSION_PATH_PLACEHOLDER + BASE_FHIR_PATH
  RESUME_PASS_PATH = '/resume_pass'.freeze
  RESUME_CLAIMS_DATA_PATH = '/resume_claims_data'.freeze
  RESUME_FAIL_PATH = '/resume_fail'.freeze

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

    def client_fhir_base_url # alias for OIDC from SMART / UDAP client tests
      fhir_base_url
    end

    def session_fhir_base_url(session_path)
      return fhir_base_url if session_path.blank?

      base_url + SESSION_BASE_FHIR_PATH.gsub(SESSION_PATH_PLACEHOLDER, "/#{session_path}")
    end

    def patient_url
      @patient_url ||= base_url + PATIENT_PATH
    end

    def resource_api_url
      @resource_api_url ||= base_url + RESOURCE_API_PATH
    end

    def session_resource_api_url(session_path)
      return resource_api_url if session_path.blank?

      base_url + SESSION_RESOURCE_API_PATH.gsub(SESSION_PATH_PLACEHOLDER, "/#{session_path}")
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
