# require 'dotenv/load' unless Rails.env.production?

module Auth0RailsEngine
  class Engine < ::Rails::Engine
    isolate_namespace Auth0RailsEngine
  end
end
