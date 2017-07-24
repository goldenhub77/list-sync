require 'rails_helper'

feature 'user joins list', %{
  As a user I should be able to join a list that I have not made
  and is public
} do

  before(:each) do
    user = FactoryGirl.create(:user)
    FactoryGirl.create(:list, public: true)
    login_as(user, scope: :user)
  end

  scenario 'user joins list', js: true do
    user = User.first
    list = List.first

    visit lists_path

    expect(page).to have_content("Join")

    click_link "Join"

    expect(page).to have_content("Joined List Successfully.")
    expect(page).to have_content(list.title)

    visit lists_path
    
    expect(page).not_to have_content("Join")
  end
end
