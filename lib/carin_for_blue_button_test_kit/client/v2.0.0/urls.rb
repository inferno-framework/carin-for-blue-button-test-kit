module CarinForBlueButtonTestKit
  TOKEN_PATH = '/mock_auth/token'.freeze
  AUTH_PATH = '/mock_auth/authorization'.freeze
  JKWS_PATH = '/.well-known/jwks.json'.freeze
  SMART_CONFIG_PATH = '/.well-known/smart-configuration'.freeze
  PATIENT_PATH = '/fhir/Patient'.freeze
  RESOURCE_API_PATH = '/fhir/:endpoint'.freeze
  RESOURCE_ID_PATH = '/fhir/:endpoint/:id'.freeze
  METADATA_PATH = '/fhir/metadata'.freeze
  BASE_FHIR_PATH = '/fhir'.freeze
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
      @authorization_url ||= base_url + AUTH_PATH
    end

    def jwks_url
      @jwks_url ||= base_url + JKWS_PATH
    end

    def smart_configuration_url
      @smart_configuration_url ||= base_url + SMART_CONFIG_PATH
    end

    def base_fhir_url
      @base_fhir_url ||= base_url + BASE_FHIR_PATH
    end

    def patient_url
      @patient_url ||= base_url + PATIENT_PATH
    end

    def submit_url
      @submit_url ||= base_url + RESOURCE_API_PATH
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
