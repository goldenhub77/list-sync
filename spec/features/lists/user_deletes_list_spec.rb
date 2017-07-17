require 'rails_helper'

feature 'user deletes list', %{
  As a user I should be able to delete existing list
} do

  before(:each) do
    4.times do
      FactoryGirl.create(:list)
    end
    login_as(List.first.user, scope: :user)
  end

  scenario 'user visits lists', js: true do
    @list = List.first

    visit list_path(@list)

    click_on "Delete"
    page.accept_alert

    expect(@list.items).to be_empty
    expect(page).to have_content("Deleted List Successfully.")
    expect(page).not_to have_content(@list.title)
  end
end
