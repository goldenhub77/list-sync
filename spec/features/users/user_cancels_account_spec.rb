require 'rails_helper'

feature 'User cancels account', %{
  As a user I should be able to cancel my account
}do

  before(:each) do
    user = FactoryGirl.create(:user)
    login_as(user, scope: :user)
  end

  scenario 'user clicks button Cancel my Account', js: true do
    user = User.first
    visit edit_user_registration_path(user)

    click_link_or_button "Cancel my account"
    page.accept_alert

    expect(page).to have_content("Bye! Your account has been successfully cancelled. We hope to see you again soon.")
    expect(page).to have_current_path(root_path)
  end
end
