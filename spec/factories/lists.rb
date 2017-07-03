FactoryGirl.define do
  factory :list do
    sequence(:title) { |n| "List Name#{n}"}
  end
end
