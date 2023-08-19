module Auth0RailsEngine
  module Auth0Authentication
    extend ActiveSupport::Concern

		private

    def auth0_client
      @auth0_client ||= Auth0Client.new(
        auth0_domain: Auth0RailsEngine.configuration.auth0_domain,
        auth0_client_id: Auth0RailsEngine.configuration.auth0_client_id,
        auth0_client_secret: Auth0RailsEngine.configuration.auth0_client_secret
      )
    end

    def current_user
      return Auth0RailsEngine.configuration.test_user if Auth0RailsEngine.configuration.test_mode && !Rails.env.production?

      token = get_token_from_headers
      @current_user ||= find_user(token)
		rescue JWT::DecodeError => e
			@current_user = nil
    end

    def get_token_from_headers
      request.headers['Authorization']&.split(' ')&.last
    end

    def find_user(token)
      return nil unless token

      auth0_id = auth0_client.get_auth0_id(token)

      Auth0RailsEngine.configuration.user_classes.call.each do |user_class|
        user = user_class.find_by(auth0_id: auth0_id)
        return user if user.present?
      end

      nil
    rescue JWT::DecodeError => e
      nil
    end

    def unauthorized_response
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end
end
