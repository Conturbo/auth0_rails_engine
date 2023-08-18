Rails.application.routes.draw do
  mount Auth0RailsEngine::Engine => "/auth0_rails_engine"
end
