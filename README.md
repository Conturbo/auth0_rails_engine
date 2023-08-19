# Auth0RailsEngine
Short description and motivation.


in main app `routes.rb`, do this:
```ruby
mount Auth0RailsEngine::Engine, at: "/auth"
```

set these env vars:
```
AUTH0_CLIENT_ID="get-this-from-auth0"
AUTH0_CLIENT_SECRET="get-this-from-auth0"
AUTH0_DOMAIN="dev-example_get-this-from-auth0yfg0h98f7g.us.auth0.com"

AUTH0_CREATE_USER_SECRET=youcanmakeupanything
```

in main app, specify user classes in this file `config/initializers/auth0_rails_engine.rb`:
```ruby
Auth0RailsEngine.configure do |config|
  config.user_classes = -> { [Employer, Applicant] } # make sure its a lambda like this
end
```

For each user model, add `auth0_id` attribute:
```ruby
bundle exec rails generate migration AddAuth0IdTo<USER_MODEL>s auth0_id:string:uniq:default:'temporary':null:false
```

For each user model, validate `auth0_id`:
```ruby
  validates :auth0_id, presence: true, uniqueness: true
```

For each user model, add `auth0_id` to its factory:
```ruby
sequence(:auth0_id) { |n| "auth0_id_#{n}" }
```

add (something like) this to your `application_controller.rb`:
```ruby
  before_action :authenticate!

  private

  def authenticate!
    @current_user = current_user      
  end
```

### Routes
User create callback route is POST `/auth/users`
