require 'rails_helper'

feature 'User signs in', %{
  As a user I should be able to sign in from LystSync directly
  or an OAuth provider (currently only Facebook)
} do

  scenario 'User signs in directly', js: true do
    user = FactoryGirl.create(:user)
    visit new_user_session_path

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password

    click_button "Log In"

      expect(page).to have_content("Signed in successfully.")
      expect(page).to have_content(user.name)
  end

  scenario 'User fails to sign in directly', js: true do
    visit new_user_session_path

    fill_in "Email", with: ""
    fill_in "Password", with: ""

    click_button "Log In"

    expect(page).not_to have_content("Signed in successfully.")
    expect(page).to have_content("Invalid Email or password.")
  end

  scenario 'User signs in using Facebook for the first time and as a returning member', js: true do
    visit new_user_session_path
    set_facebook_omniauth()

    click_link_or_button "Connect with Facebook"

    expect(page).to have_content("Sign Up")

    fill_in "Password", with: "Pa$$word5"
    fill_in "Password confirmation", with: "Pa$$word5"

    click_button "Sign Up"

    expect(page).to have_content("Welcome! You have signed up successfully.")

    click_link "Test Name"
    click_link "Sign Out"

    visit new_user_session_path
    set_facebook_omniauth()

    click_link_or_button "Connect with Facebook"

    expect(page).to have_content("Successfully authenticated from Facebook account.")
    expect(page).to have_css("img[class*='header-profile-picture']")
    expect(page).to have_content("Test Name")
  end

  scenario 'User fails to sign in using facebook', js: true do
    visit new_user_session_path
    invalid_facebook_omniauth()

    click_link_or_button "Connect with Facebook"

    expect(page).not_to have_content("Successfully authenticated from Facebook account.")
    expect(page).not_to have_css("img[class*='header-profile-picture']")
    expect(page).not_to have_content("Test Name")
    expect(page).to have_content("Sign In")
    expect(page).to have_content("Sign Up")
    expect(page).to have_current_path(root_path)
  end
end
