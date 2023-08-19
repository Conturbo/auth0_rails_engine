# spec/requests/users_request_spec.rb
require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "POST /auth/users" do
    let(:valid_headers) {
      {
        "Authorization" => "Bearer #{ENV['AUTH0_CREATE_USER_SECRET']}"
      }
    }

    let(:valid_params) {
      {
        auth0_id: "auth0|12345",
        user_role: "Applicant"
      }
    }

    it "creates an Applicant" do
      expect {
        post auth0_rails_engine.users_path, params: valid_params, headers: valid_headers
      }.to change(Applicant, :count).by(1)

      expect(response).to have_http_status(:created)
      expect(response.body).to include("User created successfully")
    end

    it "creates an Employer" do
      valid_params[:user_role] = "Employer"

      expect {
        post auth0_rails_engine.users_path, params: valid_params, headers: valid_headers
      }.to change(Employer, :count).by(1)

      expect(response).to have_http_status(:created)
      expect(response.body).to include("User created successfully")
    end

    it "returns an error for invalid user roles" do
      valid_params[:user_role] = "InvalidRole"

      post auth0_rails_engine.users_path, params: valid_params, headers: valid_headers

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.body).to include("error")
    end

    it "returns an error for missing auth token" do
      # binding.pry
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
