require "auth0_rails_engine/version"
require "auth0_rails_engine/engine"
require "auth0_rails_engine/configuration"

module Auth0RailsEngine
  def self.configure
    yield(configuration)
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  class << self
    def enable_test_mode!
      configuration.test_mode = true unless Rails.env.production?
    end

    def disable_test_mode!
      unless Rails.env.production?
        configuration.test_mode = false
        configuration.test_user = nil
      end
    end

    def set_current_user(user)
      unless Rails.env.production?
        configuration.test_user = user
      end
    end
  end
end
