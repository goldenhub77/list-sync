FactoryGirl.define do
  factory :item do
    sequence(:title) { |n| "Item title#{n}"}
    list
  end
end
