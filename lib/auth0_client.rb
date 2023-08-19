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
	
	private

	def decode_token(token)
		JWT.decode token, nil, true, { 
			algorithm: 'RS256',
			iss: "https://#{self.auth0_domain}/",
			verify_iss: true,
			aud: self.auth0_client_id,
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
end
