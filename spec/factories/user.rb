FactoryBot.define do
  factory :user do
    sequence(:auth0_id) { |n| "auth0_id_#{n}" }
  end
end
