class Auth0Client
	attr_reader :auth0_domain, :auth0_client_id, :auth0_client_secret

	def initialize(auth0_domain:, auth0_client_id:, auth0_client_secret:)
		@auth0_domain = auth0_domain
		@auth0_client_id = auth0_client_id
		@auth0_client_secret = auth0_client_secret
	end

	def get_auth0_id(token)
		decoded_token = decode_token(token)
		auth0_id = decoded_token[0]["sub"]
		return auth0_id
	rescue JWT::DecodeError => e
		raise JWT::DecodeError, e.message
	end

  def user_info(auth0_id)
    access_token = get_management_api_access_token
    user_info_url = "https://#{self.auth0_domain}/api/v2/users/#{auth0_id}"

    response = RestClient.get(user_info_url, { Authorization: "Bearer #{access_token}" })
    JSON.parse(response.body)
  rescue RestClient::Exception => e
    Rails.logger.error "Auth0 API Request Failed: #{e.message}"
    nil
  end
	
	private

	def decode_token(token)
		JWT.decode token, nil, true, { 
			algorithm: 'RS256',
			iss: "https://#{self.auth0_domain}/",
			verify_iss: true,
			aud: "https://#{self.auth0_domain}/api/v2/",
			verify_aud: true,
			jwks: jwk_loader
		}
	rescue JWT::DecodeError => e
		raise JWT::DecodeError, e.message
	end

	def jwk_loader
		@jwk_loader ||= ->(options) {
			jwks_raw = RestClient.get("https://#{self.auth0_domain}/.well-known/jwks.json").body
			jwks_keys = Array(JSON.parse(jwks_raw)['keys'])
			{
				keys: jwks_keys.map do |k|
					JSON::JWK.new(k)
				end
			}
		}
	end

	def get_management_api_access_token
    token_url = "https://#{self.auth0_domain}/oauth/token"
    payload = {
      client_id: self.auth0_client_id,
      client_secret: self.auth0_client_secret,
      audience: "https://#{self.auth0_domain}/api/v2/",
      grant_type: 'client_credentials'
    }

    response = RestClient.post(token_url, payload)
    JSON.parse(response.body)['access_token']
  rescue RestClient::Exception => e
    Rails.logger.error "Failed to retrieve Auth0 Management API token: #{e.message}"
    nil
  end
end
