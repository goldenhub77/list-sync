require 'rails_helper'

feature 'user deletes list', %{
  As a user I should be able to delete existing list
} do

  before(:each) do
    4.times do
      FactoryGirl.create(:list)
    end
  end

  scenario 'user visits lists' do
    @list = List.first

    visit list_path(@list)

    click_on "Delete"

    expect(page).to have_content("Deleted List Successfully.")
    expect(page).not_to have_content(@list.title)
  end
end
