require_relative '../tags'
require_relative '../mock_server'
require_relative '../client_validation_test'

module CarinForBlueButtonTestKit
  class ResourceAPIEndpoint < Inferno::DSL::SuiteEndpoint
    include CarinForBlueButtonTestKit::MockServer
    include CarinForBlueButtonTestKit::ClientValidationTest

    def test_run_identifier
      extract_bearer_token(request)
    end

    def make_response
      response
    end

    def add_resource_tags(tags, response_body_resource)
      if response_body_resource.resourceType == 'Bundle'
        response_body_resource.entry.each do |entry_resource|
          resource = entry_resource.resource
          resource_type_tag = resource.resourceType
          if resource.resourceType == 'ExplanationOfBenefit'
            profile = extract_eob_profile(resource)
            resource_type_tag = "#{resource.resourceType}_#{profile}"
          end
          tags.append(resource_type_tag) unless tags.include?(resource_type_tag)
        end
      else
        resource = response_body_resource
        resource_type_tag = resource.resourceType
        if resource.resourceType == 'ExplanationOfBenefit'
          profile = extract_eob_profile(resource)
          resource_type_tag = "#{resource.resourceType}_#{profile}"
        end
        tags.append(resource_type_tag) unless tags.include?(resource_type_tag)
      end
    end

    def add_search_param_tags(tags, endpoint_resource, params)
      tags.append("#{endpoint_resource}Search")
      params.keys.each do |key|
        next unless key == '_include'

        params[key].each do |value|
          params["#{key}=#{value}"] = value
        end
        params.delete(key)
      end

      params.each_key do |param|
        tags.append(param)
      end
    end

    def tags
      response_body = FHIR.from_contents(carin_resource_response(request))
      params = get_param_tags(request.query_string)

      endpoint_resource = resource_endpoint(request.url)

      tags = [RESOURCE_API_TAG]

      add_resource_tags(tags, response_body) if response_body.present?
      add_search_param_tags(tags, endpoint_resource, params)

      tags
    end

    def update_result
      results_repo.update(result.id, result: 'pass') unless test.config.options[:accepts_multiple_requests]
    end
  end
end
