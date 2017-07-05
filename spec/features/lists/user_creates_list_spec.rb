require 'rails_helper'

feature 'user creates list', %{
  As a user I should be able to create a list
} do

  scenario 'user creates public list' do

    visit new_list_path

    fill_in "Title", with: "Test list"
    check "Public"

    click_button "Create List"

    expect(page).to have_content("Created List Successfully.")
    expect(page).to have_content("Test list")
  end

  scenario 'user creates private list' do

    visit new_list_path

    fill_in "Title", with: "Test list"
    #when creating a list it defaults to a private one

    click_button "Create List"

    expect(page).to have_content("Created List Successfully.")
    expect(page).to have_content("Test list")
  end
end
