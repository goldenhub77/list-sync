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

    visit lists_path

    expect(page).to have_content("Test list")
  end

  scenario 'user creates private list' do

    visit new_list_path

    fill_in "Title", with: "Test list"
    #when creating a list it defaults to a public being unchecked

    click_button "Create List"

    expect(page).to have_content("Created List Successfully.")
    expect(page).to have_content("Test list")
    expect(page).to have_content("No Due Date")

    visit lists_path

    expect(page).not_to have_content("Test list")
  end

  scenario 'user creates list with due date' do

    date = DateTime.now + 36.hours

    visit new_list_path

    fill_in "Title", with: "Test list"
    fill_in "Due date", with: "#{date.day}/#{date.month}/#{date.year}, #{date.hour}:#{date.minute} AM"
    #when creating a list it defaults to a public being unchecked

    click_button "Create List"

    expect(page).to have_content("Created List Successfully.")
    expect(page).to have_content("Test list")
    expect(page).to have_content("1 day")

    visit lists_path

    expect(page).not_to have_content("Test list")
  end
end
