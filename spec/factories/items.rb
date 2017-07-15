FactoryGirl.define do
  factory :item do
    sequence(:title) { |n| "Item title#{n}"}
    list
    user
  end
end
