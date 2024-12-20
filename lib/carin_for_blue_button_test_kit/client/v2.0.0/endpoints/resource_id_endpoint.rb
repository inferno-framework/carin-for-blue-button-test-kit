require_relative '../tags'
require_relative '../mock_server'
require_relative '../mock_authorization'

module CarinForBlueButtonTestKit
  class ResourceIDEndpoint < Inferno::DSL::SuiteEndpoint
    include CarinForBlueButtonTestKit::MockServer
    include CarinForBlueButtonTestKit::MockAuthorization

    def test_run_identifier
      extract_client_id_from_bearer_token(request) || extract_bearer_token(request)
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
