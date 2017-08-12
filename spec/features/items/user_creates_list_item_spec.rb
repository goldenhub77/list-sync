require 'rails_helper'

feature 'user creates list item', %{
  As a user I should be able to create a list item
} do

  scenario 'user creates list item', js: true do
    user = FactoryGirl.create(:user)
    list = FactoryGirl.create(:list, user_id: user.id)
    login_as(user, scope: :user)


    visit new_list_item_path(list)

    fill_in "Title", with: "Item 1"

    click_button "Create Item"
  
    expect(page).to have_content("Created Item Successfully.")
    expect(page).to have_content(list.title)
    expect(page).to have_content("Item 1")
  end
end
