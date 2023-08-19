Rails.application.routes.draw do
  mount Auth0RailsEngine::Engine => "/auth"
end
