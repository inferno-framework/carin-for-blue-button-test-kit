require 'smart_app_launch_test_kit'
require_relative 'urls'

module CarinForBlueButtonTestKit
  module SessionIdentification
    def session_wait_identifier(client_id, session_url_path)
      # look at test config and determine the wait identifier to use
      # at somepoint this would be an inferno type, for now, just two options
      return client_id if client_id.present?
      return session_url_path if session_url_path.present?

      test_session_id
    end

    def session_url(client_id, session_url_path)
      path =
        if client_id.present?
          ''
        elsif session_url_path.present?
          session_url_path
        else
          test_session_id
        end

        session_resource_api_url(path)
    end

    # interpret the bearer token structure to determine the wait identifer
    # - if structured like a token returned by the simulated Auth server, return the client URI
    # - otherwise, use the raw token (provided token)
    def bearer_token_to_wait_identifier(token)
      client_id = SMARTAppLaunch::MockSMARTServer.issued_token_to_client_id(token)
      return client_id if client_id.present?

      token
    end
  end
end
