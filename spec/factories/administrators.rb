FactoryBot.define do
  factory :administrator do
    sequence(:email) { |n| "member#{n}@example.com" }
    suspended { false }
    password {'pw'}
  end
end
