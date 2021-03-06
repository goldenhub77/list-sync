require 'rails_helper'

feature 'User signs up directly through LystSync', %{
  As a user I should be create a new account directly within
  LystSync if I choose
} do

  scenario 'User clicks Sign Up and fills in required information', js: true do
    visit new_user_registration_path

    fill_in "Name", with: "John Smith"
    fill_in "Email", with: "jsmith77@test.com"
    fill_in "Password", with: "Pa$$word5"
    fill_in "Password confirmation", with: "Pa$$word5"

    click_button "Sign Up"

    expect(page).to have_content("Welcome! You have signed up successfully.")
    expect(page).to have_css("img[class*='header-profile-picture']")
    expect(page).to have_content("John Smith")
  end

  scenario 'User fills in false information when signing up', js: true do
    visit new_user_registration_path

    fill_in "Name", with: ""
    fill_in "Email", with: ""
    fill_in "Password", with: ""
    fill_in "Password confirmation", with: ""

    click_button "Sign Up"

    
    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content("Password can't be blank")
    expect(page).to have_content("Name can't be blank")
  end
end
