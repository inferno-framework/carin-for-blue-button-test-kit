require_relative '../tags'
require_relative '../mock_server'

module CarinForBlueButtonTestKit
  class NextPageEndpoint < Inferno::DSL::SuiteEndpoint
    include CarinForBlueButtonTestKit::MockServer

    def test_run_identifier
      extract_bearer_token(request)
    end

    def make_response
      read_next_page(request)
    end

    def tags
      [RESOURCE_API_TAG]
    end

    def update_result
      results_repo.update(result.id, result: 'pass') unless test.config.options[:accepts_multiple_requests]
    end
  end
end
