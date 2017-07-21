require 'rails_helper'

feature 'user completes list item', %{
  As a user I should be able to complete existing list item
  giving feedback and a time stamp
} do

  before(:each) do
    list = FactoryGirl.create(:list)
    FactoryGirl.create(:item, list: list)
    login_as(list.user, scope: :user)
  end
  #TEST NEEDS REFACTORING TO WORK PROPERLY
  # scenario 'user toggles incomplete to complete on first item on list show page', js: true do
  #   @list = List.first
  #   @item = @list.items.first
  #
  #   visit list_path(@list)
  #
  #   #Handles clicking completion toggle for item
  #   find('label', class: 'active', text: 'Incomplete').click
  #   @item.reload
  #
  #   expect(@item.completed).to eq(true)
  #   expect(@item.date_completed).to be_a_kind_of(DateTime)
  #   expect(page).to have_content("Completed")
  #   expect(find('p', class: 'js-item-human-date')).not_to be_empty
  # end
  #
  # scenario 'user toggles complete to incomplete on first item on list show page', js: true do
  #   @list = List.first
  #   @item = @list.items.first
  #
  #   visit list_path(@list)
  #
  #   #Handles clicking completion toggle for item
  #   find('label', text: 'Incomplete').click
  #   find('label', text: 'Completed').click
  #
  #   @item.reload
  #
  #   expect(@item.completed).to eq(false)
  #   expect(@item.date_completed).to eq(nil)
  #   expect(page).to have_content("Incomplete")
  #   expect(find('p', class: 'js-item-human-date')).to be_empty
  # end
end
