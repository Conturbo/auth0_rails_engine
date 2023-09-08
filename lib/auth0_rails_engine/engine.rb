require 'dotenv/load' unless Rails.env.production?
require 'jwt'
require 'json/jwt'
require 'rest-client'
require_relative '../auth0_client'

module Auth0RailsEngine
  class Engine < ::Rails::Engine
    isolate_namespace Auth0RailsEngine
  end
end
