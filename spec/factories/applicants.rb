FactoryBot.define do
  factory :applicant do
    sequence(:auth0_id) { |n| "auth0_id_#{n}" }
  end
end
