require 'rails_helper'

feature 'user sees list items', %{
  As a user I should be able to view all
  items for a particular list
} do

  before(:each) do
    list = FactoryGirl.create(:list)
    4.times do
      FactoryGirl.create(:item, list: list)
    end
  end

  scenario 'user visits a list and sees all items' do
    @list = List.first

    visit list_path(@list)

    @list.items.each do |item|
      expect(page).to have_content(item.title)
    end
  end
end
