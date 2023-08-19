Auth0RailsEngine.configure do |config|
  config.user_classes = -> { [Employer, Applicant] }
	config.auth0_client_id = ENV['AUTH0_CLIENT_ID']
	config.auth0_client_secret = ENV['AUTH0_CLIENT_SECRET']
	config.auth0_domain = ENV['AUTH0_DOMAIN']
	config.auth0_create_user_secret = ENV['AUTH0_CREATE_USER_SECRET']
end
