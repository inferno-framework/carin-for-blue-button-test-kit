require_relative '../tags'
require_relative '../mock_server'

module CarinForBlueButtonTestKit
  class SubmitClaimsEndpoint < Inferno::DSL::SuiteEndpoint
    include CarinForBlueButtonTestKit::MockServer

    def test_run_identifier
      extract_bearer_token(request)
    end

    def make_response
      carin_resource_response(request)
    end

    def tags
      params = get_params(request.query_string)
      param_string = params.keys.map(&:to_s).join('_')
      [SUBMIT_TAG, param_string]
    end

    def update_result
      results_repo.update(result.id, result: 'pass') unless test.config.options[:accepts_multiple_requests]
    end
  end
end
