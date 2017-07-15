FactoryGirl.define do
  factory :user do
    name "Test User"
    password "Fak3Pa$$word"
    sequence(:email) { |n| "fakeEmail#{n}@fakeemail.com" }
  end
end
