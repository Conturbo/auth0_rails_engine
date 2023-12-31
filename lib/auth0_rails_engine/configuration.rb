module Auth0RailsEngine
  class Configuration
    attr_accessor :auth0_client_id, :auth0_client_secret, :auth0_domain, :auth0_create_user_secret, :test_mode, :test_user

    def initialize
			@auth0_client_id = ''
			@auth0_client_secret = ''
			@auth0_domain = ''
			@auth0_create_user_secret = ''

      @test_mode = Rails.env.test?
      @test_user = nil
    end
  end
end
