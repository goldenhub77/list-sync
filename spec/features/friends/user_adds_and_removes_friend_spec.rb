require 'rails_helper'

feature 'user adds and removes friend', %{
  As a user I should be able to add and/or remove
  a friend
} do

  before(:each) do
    user1 = FactoryGirl.create(:user)
    user2 = FactoryGirl.create(:user)
    login_as(user1, scope: :user)
  end

  scenario 'guest tries to get to friends page', js: true do
    logout
    visit users_path

    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end

  scenario 'user adds then removes friend', js: true do
    user1 = User.first
    friend = User.second

    visit users_path

    click_link "Add Friend", id: "friend-btn-#{friend.id}"

    expect(page).to have_content("You are now friends with #{friend.name}")
    expect(page).to have_link('Unfriend', id: "unfriend-btn-#{friend.id}")

    click_link "Unfriend", id: "unfriend-btn-#{friend.id}"

    expect(page).to have_content("You are no longer friends with #{friend.name}")
    expect(page).to have_link("Add Friend", id: "friend-btn-#{friend.id}")
  end
end
