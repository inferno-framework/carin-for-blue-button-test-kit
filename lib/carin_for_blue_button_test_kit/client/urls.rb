module CarinForBlueButtonTestKit
  TOKEN_PATH = '/mock_auth/token'
  PATIENT_PATH = '/fhir/Patient'
  SUBMIT_PATH = '/fhir/:endpoint'
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

    def base_fhir_url
      @base_fhir_url ||= base_url + BASE_FHIR_PATH
    end

    def patient_url
      @patient_url ||= base_url + PATIENT_PATH
    end

    def submit_url
      @submit_url ||= base_url + SUBMIT_PATH
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
      self.class.suite.id
    end
  end
end
