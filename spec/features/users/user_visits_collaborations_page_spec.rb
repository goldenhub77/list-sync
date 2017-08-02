require 'rails_helper'

feature 'user visits collaborations page', %{
  As a user I should be able to view my list collaborations
  including other users if you are an admin
} do

  before(:each) do
    user1 = FactoryGirl.create(:user)
    user2 = FactoryGirl.create(:user)
    list = FactoryGirl.create(:list, user: user1, public: true)
    FactoryGirl.create(:lists_user, user: user2, list: list )
    login_as(user2, scope: :user)
  end

  scenario 'user views My Collaborations page', js: true do
    user2 = User.second
    list = List.first

    visit user_collaborations_path(user2)

    expect(page).to have_content(list.title.humanize)
  end

  scenario 'user2 views user1 collaborations page', js: true do
    user1 = User.first
    list = List.first

    visit user_collaborations_path(user1)

    expect(page).to have_content('You cannot view this users collaborations')
    expect(page).not_to have_content(list.title)
  end

  scenario 'admin views user2 collaborations page', js: true do
    admin = FactoryGirl.create(:user, admin: true)
    user2 = User.second
    list = List.first
    logout
    login_as(admin, scope: :user)

    visit user_collaborations_path(user2)

    expect(page).to have_content(list.title.humanize)
  end
end
