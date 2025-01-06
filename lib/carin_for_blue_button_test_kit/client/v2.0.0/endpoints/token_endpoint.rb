require_relative '../tags'
require_relative '../urls'
require_relative '../mock_server'
require_relative '../mock_authorization'

module CarinForBlueButtonTestKit
  module MockAuthorization
    AUTHORIZED_PRACTITIONER_ID = 'c4bb-Practitioner'.freeze # Must exist on the FHIR_REFERENCE_SERVER (env var)
    CARIN_PATIENT_ID = '888'.freeze # Must exist on the FHIR_REFERENCE_SERVER (env var)

    class TokenEndpoint < Inferno::DSL::SuiteEndpoint
      include CarinForBlueButtonTestKit::MockServer

      def test_run_identifier
        extract_client_id
      end

      def tags
        [TOKEN_TAG]
      end

      def make_response
        client_id = extract_client_id
        access_token = JWT.encode({ inferno_client_id: client_id }, nil, 'none')
        granted_scopes = SUPPORTED_SCOPES & requested_scopes

        response_hash = { access_token:, scope: granted_scopes.join(' '), token_type: 'bearer',
                          expires_in: 3600 }

        response_hash.merge!(patient: CARIN_PATIENT_ID)

        response.body = response_hash.to_json
        response.headers['Cache-Control'] = 'no-store'
        response.headers['Pragma'] = 'no-cache'
        response.status = 200
      end

      private

      def extract_client_id
        # Public client            || confidential client asymmetric          || confidential client symmetric
        request.params[:client_id] || extract_client_id_from_client_assertion || extract_client_id_from_basic_auth
      end

      def extract_client_id_from_client_assertion
        encoded_jwt = request.params[:client_assertion]
        return unless encoded_jwt.present?

        jwt_payload =
          begin
            JWT.decode(encoded_jwt, nil, false)&.first # skip signature verification
          rescue StandardError
            nil
          end

        jwt_payload['iss'] || jwt_payload['sub'] if jwt_payload.present?
      end

      def extract_client_id_from_basic_auth
        encoded_credentials = request.headers['authorization']&.delete_prefix('Basic ')
        return unless encoded_credentials.present?

        decoded_credentials = Base64.decode64(encoded_credentials)
        decoded_credentials&.split(':')&.first
      end

      def requested_scopes
        auth_request = requests_repo.tagged_requests(result.test_session_id, [AUTHORIZE_TAG]).last
        return [] unless auth_request

        auth_params = if auth_request.verb.downcase == 'get'
                        auth_request.query_parameters
                      else
                        URI.decode_www_form(auth_request.request_body)&.to_h
                      end
        scope_str = auth_params&.dig('scope')
        scope_str ? URI.decode_www_form_component(scope_str).split : []
      end
    end
  end
end
