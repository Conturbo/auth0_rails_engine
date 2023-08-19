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
end
