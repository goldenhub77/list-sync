require 'rails_helper'

feature 'User searches lists or users', %{
  As a user I should be able to search for a user or list
  from any page and be returned only results current_user has
  access to
} do

  before(:each) do
    user = FactoryGirl.create(:user)
    4.times do
      FactoryGirl.create(:user)
    end
    4.times do
      list = FactoryGirl.create(:list, user: user)
      FactoryGirl.create(:lists_user, list: list, user: user)
    end
    3.times do
      FactoryGirl.create(:list, user: User.third)
    end
    login_as(user, scope: :user)
  end

  scenario 'guest(not signed in) tries to search', js: true do
    logout

    visit root_path
    search_input = find('#js-global-search-input')
    search_btn = find('#js-global-search-btn')

    expect(search_input).to be_present
    expect(search_btn).to be_present

    click_link_or_button "js-global-search-btn"

    expect(page).to have_content("You need to sign in or sign up before continuing.")
    expect(page).to have_current_path(new_user_session_path)
  end

  scenario 'Admin searches for a list and user associated or not', js: true do
    admin = FactoryGirl.create(:user, admin: true)
    list = List.second
    user = User.third
    logout
    login_as(admin, scope: :user)

    visit root_path

    search_input = find('#js-global-search-input')
    search_btn = find('#js-global-search-btn')

    expect(search_input).to be_present
    expect(search_btn).to be_present

    # search for a specifc list and multiple lists
    fill_in "js-global-search-input", with: list.title
    click_link_or_button "js-global-search-btn"

    expect(page).to have_content(list.title.humanize)
    expect(page).to have_content("1 result")
    expect(page).to have_current_path("/search?utf8=%E2%9C%93&q=#{list.title.gsub(' ', '+')}")

    fill_in "js-global-search-input", with: "list name"
    click_link_or_button "js-global-search-btn"

    List.all.each do |list|
      expect(page).to have_content(list.title.humanize)
    end
    expect(page).to have_content("7 results")
    expect(page).to have_current_path('/search?utf8=%E2%9C%93&q=list+name')

    # search for a specifc user and multiple users
    fill_in "js-global-search-input", with: user.name
    click_link_or_button "js-global-search-btn"

    expect(page).to have_content(user.name)
    expect(page).to have_content("1 result")
    expect(page).to have_current_path("/search?utf8=%E2%9C%93&q=#{user.name.gsub(' ', '+')}")

    fill_in "js-global-search-input", with: "test user"
    click_link_or_button "js-global-search-btn"

    User.all.each do |list|
      expect(page).to have_content(user.name)
    end
    expect(page).to have_content("6 results")
    expect(page).to have_current_path('/search?utf8=%E2%9C%93&q=test+user')
  end

  scenario 'User searches for a list and user associated', js: true do
    #lists 1-4 have an association with this user
    list_search = List.fifth
    user_logged_in = User.first

    visit root_path

    search_input = find('#js-global-search-input')
    search_btn = find('#js-global-search-btn')

    expect(search_input).to be_present
    expect(search_btn).to be_present

    # search for a specifc list and multiple lists
    fill_in "js-global-search-input", with: list_search.title
    click_link_or_button "js-global-search-btn"

    expect(page).to have_content("0 results No search results for '#{list_search.title}' found.")
    expect(page).to have_current_path("/search?utf8=%E2%9C%93&q=#{list_search.title.gsub(' ', '+')}")

    fill_in "js-global-search-input", with: "list name"
    click_link_or_button "js-global-search-btn"

    List.all.each.with_index do |list, index|
      if index < 4
        expect(page).to have_content(list.title.humanize)
      else
        expect(page).not_to have_content(list.title.humanize)
      end
    end

    expect(List.all.count).to eq(7)
    expect(page).to have_content("4 results")
    expect(page).to have_current_path('/search?utf8=%E2%9C%93&q=list+name')
    # user_searches_spec.rb NEEDS TO BE REFACTORED FOR FRIENDS
  end

  scenario 'User searches for a list and user not associated', js: true do
    #lists 1-4 have an association with this user
    list_search = List.second
    user_logged_in = User.first

    visit root_path

    search_input = find('#js-global-search-input')
    search_btn = find('#js-global-search-btn')

    expect(search_input).to be_present
    expect(search_btn).to be_present

    # search for a specifc list and multiple lists
    fill_in "js-global-search-input", with: list_search.title
    click_link_or_button "js-global-search-btn"

    expect(page).to have_content(list_search.title.humanize)
    expect(page).to have_content("1 result")
    expect(page).to have_current_path("/search?utf8=%E2%9C%93&q=#{list_search.title.gsub(' ', '+')}")

    fill_in "js-global-search-input", with: "list name"
    click_link_or_button "js-global-search-btn"

    user_logged_in.list_collaborations.each do |list|
      expect(page).to have_content(list.title.humanize)
    end
    expect(page).to have_content("4 results")
    expect(page).to have_current_path('/search?utf8=%E2%9C%93&q=list+name')
    # user_searches_spec.rb NEEDS TO BE REFACTORED FOR FRIENDS
  end

  scenario 'User searches with no query entered', js: true do
    visit root_path
    search_input = find('#js-global-search-input')
    search_btn = find('#js-global-search-btn')

    expect(search_input).to be_present
    expect(search_btn).to be_present

    fill_in "js-global-search-input", with: ""
    click_link_or_button "js-global-search-btn"

    expect(page).to have_content("Please enter a search query.")
    expect(page).to have_content("0 results")
    expect(page).to have_current_path('/search?utf8=%E2%9C%93&q=')
  end
end
