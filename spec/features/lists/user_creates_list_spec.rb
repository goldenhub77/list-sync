require 'rails_helper'

feature 'user creates list', %{
  As a user I should be able to create a list
} do

  before(:each) do
    user = FactoryGirl.create(:user)
    login_as(user, scope: :user)
  end

  scenario 'user creates public list', js: true do

    visit new_list_path

    fill_in "Title", with: "Test list"
    # handles toggling "Public" option on form
    find('label', class: 'active').click


    click_button "Create List"

    expect(page).to have_content("Created List Successfully.")
    expect(page).to have_content("Test list")

    visit lists_path

    expect(page).to have_content("Test list")
  end

  scenario 'user creates private list' do

    visit new_list_path

    fill_in "Title", with: "Test list"
    #when creating a list it defaults to public being unchecked

    click_button "Create List"

    expect(page).to have_content("Created List Successfully.")
    expect(page).to have_content("Test list")
    expect(page).to have_content("No Due Date")

    visit lists_path

    expect(page).not_to have_content("Test list")
  end

  scenario 'user creates list with due date', js: true do

    date = (DateTime.now + 36.hours).to_s

    visit new_list_path

    fill_in "Title", with: "Test list"
    #inputs formatted date into Due date field
    #changes hidden field to normal text field so selenium will enter value
    execute_script("$('#js-list-due-date')[0].setAttribute('type', 'text');");
    #updates Due date with a test date
    find('input', id: 'js-list-due-date', visible: false).set(date)
    #when creating a list it defaults to public being unchecked

    click_button "Create List"

    expect(page).to have_content("Created List Successfully.")
    expect(page).to have_content("Test list")
    expect(page).to have_content("1 day")

    visit lists_path

    expect(page).not_to have_content("Test list")
  end
end
