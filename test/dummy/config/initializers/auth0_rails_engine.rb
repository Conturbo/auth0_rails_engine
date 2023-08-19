Auth0RailsEngine.configure do |config|
  config.user_classes = -> { [Employer, Applicant] }
end
