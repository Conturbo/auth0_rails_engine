class Auth0RailsEngine::UsersController < Auth0RailsEngine::ApplicationController
	before_action :authenticate_request_is_from_auth0!

  def create
    User.create!(auth0_id: params[:user][:auth0_id])
    render json: { message: "User created successfully" }, status: :created
  rescue => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

	private

	def authenticate_request_is_from_auth0!
    token = get_token_from_headers
    return unauthorized_response unless token
    
    if token == Auth0RailsEngine.configuration.auth0_create_user_secret
      return
    else
      unauthorized_response
    end
	end

  def user_classes
    Auth0RailsEngine.configuration.user_classes.call
  end
end
