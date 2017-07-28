FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "Test User#{n}" }
    password "Fak3Pa$$word"
    sequence(:email) { |n| "fakeEmail#{n}@fakeemail.com" }
  end
end
