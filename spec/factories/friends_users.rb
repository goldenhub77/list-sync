FactoryGirl.define do
  factory :friends_user do
    user
    friend { FactoryGirl.create(:user) }
  end
end
