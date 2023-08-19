module Auth0RailsEngine
  class ApplicationController < ActionController::API
    include Auth0Authentication
  end
end
