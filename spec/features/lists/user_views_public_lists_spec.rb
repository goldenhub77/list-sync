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
      FactoryGirl.create(:list, public: true)
    end
    login_as(List.first.user, scope: :user)
  end

  scenario 'user visits lists' do
    visit lists_path

    expect(List.public.count).to eq(2)

    List.all.each do |list|
      if list.public == false
        expect(page).not_to have_content(list.title)
      elsif list.public == true
        expect(page).to have_content(list.title.titleize)
        expect(page).to have_content("No Due Date")
      end
    end
  end
end
