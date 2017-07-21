require 'rails_helper'

feature 'user deletes list item', %{
  As a user I should be able to delete existing item from a list
} do

  before(:each) do
    list = FactoryGirl.create(:list)
    FactoryGirl.create(:item, list: list, user: list.user)
    login_as(list.user, scope: :user)
  end

  scenario 'user delete first item from list show page', js: true do
    @list = List.first
    @item = @list.items.first

    visit user_list_path(@list.user, @list)

    click_on "delete-item-#{@item.id}"
    page.accept_alert

    expect(page).to have_content("Deleted Item Successfully.")
    expect(page).not_to have_content(@item.title)
  end

  scenario 'user delete item from item show page', js: true do
    @list = List.first
    @item = @list.items.first

    visit list_item_path(@list, @item)

    click_on "Delete"
    page.accept_alert

    expect(page).to have_content("Deleted Item Successfully.")
    expect(page).not_to have_content(@item.title)
  end
end
