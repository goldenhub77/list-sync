require "rails_helper"

feature "profile photo" do
  scenario "user uploads a profile photo", js: true do
    visit root_path
    click_link "Sign Up"

    fill_in "Name", with: "Test User"
    fill_in "Email", with: "test@test.com"
    fill_in "Password", with: "Pa$$word5"
    fill_in "Password confirmation", with: "Pa$$word5"
    attach_file "user_profile_picture", "#{Rails.root}/spec/support/images/good_photo.png"
    click_button "Sign Up"

    expect(page).to have_content("Welcome! You have signed up successfully.")

    visit edit_user_registration_path

    expect(page).to have_content("Current: good_photo.png")
  end
end
