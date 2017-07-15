require 'rails_helper'

feature 'user updates list', %{
  As a user I should be able to update existing list
} do

  before(:each) do
    4.times do
      FactoryGirl.create(:list)
    end
    login_as(List.first.user, scope: :user)
  end

  scenario 'user updates list' do
    @list = List.first

    visit edit_list_path(@list)

    expect(find_field("Title").value).to eq(@list.title)

    fill_in "Title", with: "Test list"

    click_on "Update List"
    @list.reload

    expect(page).to have_content("Updated List Successfully.")
    expect(page).to have_content("Test list")
    expect(page).to have_content("No Due Date")
  end

  scenario 'user updates list with due date' do
    @list = List.first
    date = DateTime.now + 36.hours

    visit edit_list_path(@list)

    expect(find_field("Title").value).to eq(@list.title)

    fill_in "Title", with: "Test list"
    #server reads due date params from a hidden input field
    find(:xpath, "//input[@id='js-list-due-date']", visible: false).set date.to_s

    click_on "Update List"
    @list.reload

    expect(page).to have_content("Updated List Successfully.")
    expect(page).to have_content("Test list")
    expect(page).to have_content("1 day")
  end
end
