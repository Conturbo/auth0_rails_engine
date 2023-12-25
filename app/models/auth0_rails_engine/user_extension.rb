module Auth0RailsEngine
  module UserExtension
    extend ActiveSupport::Concern

    included do
      # Define any callbacks or validations if needed
    end

    # Instance method to fetch user data from Auth0
    def fetch_auth0_data
      # Assuming you have a method in your Auth0Client to fetch user details
      auth0_client.user_info(self.auth0_id)
    end

    # Method to get specific attribute (e.g., email) from Auth0 data
    def get_auth0_attribute(attribute)
      auth0_data = fetch_auth0_data
      auth0_data[attribute]
    rescue StandardError => e
      Rails.logger.error "Failed to fetch data from Auth0: #{e.message}"
      nil
    end

		private

    def auth0_client
      @auth0_client ||= Auth0Client.new(
        auth0_domain: Auth0RailsEngine.configuration.auth0_domain,
        auth0_client_id: Auth0RailsEngine.configuration.auth0_client_id,
        auth0_client_secret: Auth0RailsEngine.configuration.auth0_client_secret
      )
    end
  end
end
