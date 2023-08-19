module Auth0RailsEngine
  class Configuration
    attr_accessor :user_classes, :auth0_client_id, :auth0_client_secret, :auth0_domain, :auth0_create_user_secret

    def initialize
      @user_classes = []
			@auth0_client_id = ''
			@auth0_client_secret = ''
			@auth0_domain = ''
			@auth0_create_user_secret = ''
    end
  end
end
