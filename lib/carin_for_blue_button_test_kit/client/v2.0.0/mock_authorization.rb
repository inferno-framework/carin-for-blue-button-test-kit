module CarinForBlueButtonTestKit
  module MockAuthorization
    RSA_PRIVATE_KEY = OpenSSL::PKey::RSA.generate(2048)
    RSA_PUBLIC_KEY = RSA_PRIVATE_KEY.public_key

    module_function

    def extract_client_id_from_bearer_token(request)
      token = request.headers['authorization']&.delete_prefix('Bearer ')
      jwt =
        begin
          JWT.decode(token, nil, false)
        rescue StandardError
          nil
        end
      jwt&.first&.dig('inferno_client_id')
    end

    def jwks(_env)
      response_body = {
        keys: [
          {
            kty: 'RSA',
            alg: 'RS256',
            n: Base64.urlsafe_encode64(RSA_PUBLIC_KEY.n.to_s(2), padding: false),
            e: Base64.urlsafe_encode64(RSA_PUBLIC_KEY.e.to_s(2), padding: false),
            use: 'sig'
          }
        ]
      }.to_json

      [200, { 'Content-Type' => 'application/json' }, [response_body]]
    end
  end
end
