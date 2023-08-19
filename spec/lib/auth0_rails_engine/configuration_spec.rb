require 'rails_helper'

RSpec.describe Auth0RailsEngine::Configuration do
  it 'correctly configures user classes' do
    user_classes = Auth0RailsEngine.configuration.user_classes.call
    expect(user_classes).to contain_exactly(Employer, Applicant)
  end
end
