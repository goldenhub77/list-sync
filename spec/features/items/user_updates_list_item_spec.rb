require 'rails_helper'

feature 'user updates list item', %{
  As a user I should be able to update existing list item
} do

  before(:each) do
    list = FactoryGirl.create(:list)
    4.times do
      FactoryGirl.create(:item, list: list)
    end
  end

  scenario 'user updates first item from list' do
    @list = List.first
    @item = @list.items.first

    visit edit_list_item_path(@list, @item)

    expect(find_field("Title").value).to eq(@item.title)

    fill_in "Title", with: "Different item"

    click_on "Update Item"
    @item.reload

    expect(page).to have_content("Updated Item Successfully.")
    expect(page).to have_content("Different item")
  end
end
