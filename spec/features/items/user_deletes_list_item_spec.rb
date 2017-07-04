require 'rails_helper'

feature 'user deletes list item', %{
  As a user I should be able to delete existing item from a list
} do

  before(:each) do
    list = FactoryGirl.create(:list)
    4.times do
      FactoryGirl.create(:item, list: list)
    end
  end

  scenario 'user delete first item from list show page' do
    @list = List.first
    @item = @list.items.first

    visit list_path(@list)

    click_on "delete-item-#{@item.id}"

    expect(page).to have_content("Deleted Item Successfully.")
    expect(page).not_to have_content(@item.title)
  end

  scenario 'user delete item from item show page' do
    @list = List.first
    @item = @list.items.first

    visit list_item_path(@list, @item)

    click_on "Delete"

    expect(page).to have_content("Deleted Item Successfully.")
    expect(page).not_to have_content(@item.title)
  end
end
