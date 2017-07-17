require 'rails_helper'

feature 'user updates list item', %{
  As a user I should be able to update existing list item
} do

  before(:each) do
    list = FactoryGirl.create(:list)
    4.times do
      FactoryGirl.create(:item, list: list)
    end
    login_as(list.user, scope: :user)
  end

  scenario 'user updates first item from list from list show page', js: true do
    @list = List.first
    @item = @list.items.first

    visit list_path(@list)

    click_on "edit-item-#{@item.id}"

    expect(find_field("Title").value).to eq(@item.title)

    fill_in "Title", with: "Different item"

    click_on "Update Item"
    @item.reload

    expect(page).to have_content("Updated Item Successfully.")
    expect(page).to have_content("Different item")
  end

  scenario 'user updates first item from list from list show page', js: true do
    @list = List.first
    @item = @list.items.first

    visit list_item_path(@list, @item)

    click_on "Edit"

    expect(find_field("Title").value).to eq(@item.title)

    fill_in "Title", with: "Different item"

    click_on "Update Item"
    @item.reload

    expect(page).to have_content("Updated Item Successfully.")
    expect(page).to have_content("Different item")
  end
end
