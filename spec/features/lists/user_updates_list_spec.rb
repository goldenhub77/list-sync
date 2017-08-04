require 'rails_helper'

feature 'user updates list', %{
  As a user I should be able to update existing list
} do

  before(:each) do
    FactoryGirl.create(:list)
    login_as(List.first.user, scope: :user)
  end

  scenario 'user updates list', js: true do
    @list = List.first

    visit edit_list_path(@list)

    expect(find_field("Title").value).to eq(@list.title)

    fill_in "Title", with: "Test list"

    click_on "Update List"
    @list.reload

    expect(page).to have_content("Updated List Successfully.")
    expect(page).to have_content("Test List")
    expect(page).to have_content("No Due Date")
  end

  scenario 'user updates list with due date', js: true do
    @list = List.first
    date = (DateTime.now + 36.hours).to_s

    visit edit_list_path(@list)

    expect(find_field("Title").value).to eq(@list.title)

    fill_in "Title", with: "Test list"

    #server reads due date params from a hidden input field
    #simulate user picking datetime
    execute_script("$('#js-list-due-date')[0].value = '#{date}';")
    #when creating a list it defaults to public being unchecked


    click_on "Update List"
    @list.reload

    expect(page).to have_content("Updated List Successfully.")
    expect(page).to have_content("Test List")
    expect(page).to have_content("1 day")
  end
end
