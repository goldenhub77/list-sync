require 'rails_helper'

feature 'user sees only public lists', %{
  As a user I should be able to view all
  lists created as long as they are public
} do

  before(:each) do
    2.times do
      FactoryGirl.create(:list)
    end
    2.times do
      FactoryGirl.create(:list, public: false)
    end
  end

  scenario 'user visits lists' do
    visit lists_path
    public_lists = List.public
    expect(List.public.count).to eq(2)
    public_lists.each do |list|
      expect(page).to have_content(list.title)
    end
  end
end
