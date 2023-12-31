# spec/requests/users_request_spec.rb
require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "POST /auth/users" do
    let(:valid_headers) {
      {
        "Authorization" => "Bearer #{Auth0RailsEngine.configuration.auth0_create_user_secret}"
      }
    }

    let(:valid_params) {
      {
        user: {
          auth0_id: "auth0|12345"
        }
      }
    }

    it "creates a User" do
      expect {
        post auth0_rails_engine.users_path, params: valid_params, headers: valid_headers
				puts response.body
      }.to change(User, :count).by(1)

      expect(response).to have_http_status(:created)
      expect(response.body).to include("User created successfully")
    end

    it "returns an error for missing auth token" do
      post auth0_rails_engine.users_path, params: valid_params

      expect(response).to have_http_status(:unauthorized)
    end

    it "returns an error for invalid auth token" do
      valid_headers["Authorization"] = "Bearer invalid_token"

      post auth0_rails_engine.users_path, params: valid_params, headers: valid_headers

      expect(response).to have_http_status(:unauthorized)
    end
  end
end
