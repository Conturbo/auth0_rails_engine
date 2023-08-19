source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Specify your gem's dependencies in auth0_rails_engine.gemspec.
gemspec

gem "puma"

gem "sqlite3"

group :development, :test do
  gem 'dotenv'
  gem 'pry-rails'
  gem 'rubocop'
  gem 'rspec-rails'
end

group :test do
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'shoulda-matchers'
  gem 'simplecov', require: false
end
