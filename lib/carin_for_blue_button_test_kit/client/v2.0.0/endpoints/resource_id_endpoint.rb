require 'udap_security_test_kit'
require_relative '../tags'
require_relative '../mock_server'

module CarinForBlueButtonTestKit
  class ResourceIDEndpoint < Inferno::DSL::SuiteEndpoint
    include CarinForBlueButtonTestKit::MockServer

    def test_run_identifier
      return request.params[:session_path] if request.params[:session_path].present?

      UDAPSecurityTestKit::MockUDAPServer.issued_token_to_client_id(
        request.headers['authorization']&.delete_prefix('Bearer ')
      )
    end

    def make_response
      carin_resource_id_response(request)
    end

    def tags
      [RESOURCE_ID_TAG]
    end

    def update_result
      results_repo.update(result.id, result: 'pass') unless test.config.options[:accepts_multiple_requests]
    end
  end
end
