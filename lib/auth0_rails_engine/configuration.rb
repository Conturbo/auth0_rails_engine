module Auth0RailsEngine
  class Configuration
    attr_accessor :user_classes

    def initialize
      @user_classes = []
    end
  end
end
