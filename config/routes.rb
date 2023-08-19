Auth0RailsEngine::Engine.routes.draw do
	resources :users, only: [:create]
end
