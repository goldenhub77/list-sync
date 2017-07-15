require 'rails_helper'

feature 'User updates account information', %{
  As a user I should be able to update my personal information
  it is deemed necessary or a security concern arises
} do

  before(:each) do
    user = FactoryGirl.create(:user)
    login_as(user, scope: :user)
  end

  scenario 'User updates account information' do
    user = User.first
    visit edit_user_registration_path(user)

    unchanged_name = user.name
    unchanged_email = user.email
    current_password = user.encrypted_password

    fill_in "Name", with: "Different Name"
    fill_in "Email", with: "differentemail@test.com"
    fill_in "Password", with: "newpasS5$"
    fill_in "Password confirmation", with: "newpasS5$"
    fill_in "Current password", with: "Fak3Pa$$word"

    click_link_or_button "Update"

    user.reload

    expect(unchanged_name).not_to eq(user.name)
    expect(unchanged_email).not_to eq(user.email)
    expect(current_password).not_to eq(user.encrypted_password)
    expect(page).to have_content("Your account has been updated successfully.")
    expect(page).to have_current_path(root_path)
  end

  scenario 'User fails to update account information' do
    user = User.first
    visit edit_user_registration_path(user)

    unchanged_name = user.name
    unchanged_email = user.email
    current_password = user.encrypted_password

    fill_in "Name", with: "Different Name"
    fill_in "Email", with: "differentemail@test.com"
    fill_in "Password", with: "newpasS5$"
    fill_in "Password confirmation", with: "newpasS5$"
    fill_in "Current password", with: "wrongpassword"

    click_link_or_button "Update"

    user.reload

    expect(unchanged_name).to eq(user.name)
    expect(unchanged_email).to eq(user.email)
    expect(current_password).to eq(user.encrypted_password)
    expect(page).to have_content("User Current password is invalid")
  end
end
