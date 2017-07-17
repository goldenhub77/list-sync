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
      expect(page).to have_content(user.email)

  end

  scenario 'User fails to sign in directly', js: true do
      visit new_user_session_path

      fill_in "Email", with: ""
      fill_in "Password", with: ""

      click_button "Log In"

      expect(page).not_to have_content("Signed in successfully.")
      expect(page).to have_content("Invalid Email or password.")

  end

  scenario 'User signs in using Facebook', js: true do
      visit new_user_session_path
      set_facebook_omniauth()

      click_link_or_button "Connect with Facebook"

      expect(page).to have_content("Successfully authenticated from Facebook account.")
      expect(page).to have_content("test@test.com")
  end

  scenario 'User fails to sign in using facebook', js: true do
      visit new_user_session_path
      invalid_facebook_omniauth()

      click_link_or_button "Connect with Facebook"

      expect(page).not_to have_content("Successfully authenticated from Facebook account.")
      expect(page).not_to have_content("test@test.com")
      expect(page).to have_content("Sign In")
      expect(page).to have_content("Sign Up")
      expect(page).to have_current_path(root_path)
  end
end
