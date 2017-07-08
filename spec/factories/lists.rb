FactoryGirl.define do
  factory :list do
    sequence(:title) { |n| "List Name#{n}"}
    public false
    due_date nil 
  end
end
