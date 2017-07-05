require 'rails_helper'

feature 'user views list show page', %{
  As a user I should be able to view existing list show page
} do

  before(:each) do
    4.times do
      FactoryGirl.create(:list)
    end
  end

  scenario 'user visits lists show page' do
    @list = List.first

    visit list_path(@list)

    expect(page).to have_content(@list.title)
    expect(page).to have_link("Edit")
    expect(page).to have_link("Delete")
  end
end
