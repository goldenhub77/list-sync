require 'rails_helper'

feature 'user views list item', %{
  As a user I should be able to view existing list
} do

  before(:each) do
    list = FactoryGirl.create(:list)
    4.times do
      FactoryGirl.create(:item, list: list)
    end
    login_as(list.user, scope: :user)
  end

  scenario 'user visits list item' do
    @list = List.first
    @item = @list.items.first

    visit list_path(@list)

    click_on @item.title

    expect(page).to have_content(@item.title)
    expect(page).to have_link("Edit")
    expect(page).to have_link("Delete")
  end
end
