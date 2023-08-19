class Auth0RailsEngine::UsersController < Auth0RailsEngine::ApplicationController
	before_action :authenticate_request_is_from_auth0!

  def create
    user_role = params[:user_role]
    user_class = user_classes.find { |klass| klass.to_s == user_role }

    if user_class
      user_class.create!(auth0_id: params[:auth0_id])
      render json: { message: "User created successfully" }, status: :created
    else
      render json: { error: "Invalid user role" }, status: :unprocessable_entity
    end
  rescue => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

	private

	def authenticate_request_is_from_auth0!
    token = get_token_from_headers
    return unauthorized_response unless token

    if token == ENV['AUTH0_CREATE_USER_SECRET']
      return
    else
      unauthorized_response
    end
	end

  def user_classes
    Auth0RailsEngine.configuration.user_classes.call
  end
end
