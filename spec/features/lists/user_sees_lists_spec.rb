require 'rails_helper'

feature 'user sees lists', %{
  As a user I should be able to view
  lists created
} do

  before(:each) do
    4.times do
      FactoryGirl.create(:list)
    end
  end

  scenario 'user visits lists' do
    visit lists_path

    List.all.each do |list|
      expect(page).to have_content(list.title)
    end
  end
end
