# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'factory_girl_rails'

#creates 20 standard users and 1 admin
if User.count == 0
  #creates an admin
  FactoryGirl.create(:user, name: "John Smith", email: "jsmith@test.com", admin: true)
  20.times do
    FactoryGirl.create(:user)
  end
end

#creates 10 public lists
groceries = List.find_or_create_by(title: "groceries", user: User.second, public: true)
homework = List.find_or_create_by(title: "homework", user: User.second, public: true)
deck = List.find_or_create_by(title: "build deck", user: User.third, public: true)
college = List.find_or_create_by(title: "save for college", user: User.third, public: true)
stocks = List.find_or_create_by(title: "create stock portfolio", user: User.fourth, public: true)
kickstarter = List.find_or_create_by(title: "start kickstarter campaign", user: User.fourth, public: true)
youtube = List.find_or_create_by(title: "organize youtube channel", user: User.fifth, public: true)
checkbook = List.find_or_create_by(title: "balance checkbook", user: User.last, public: true)
retirement = List.find_or_create_by(title: "move retirement 401k to different account", user: User.last, public: true)
website = List.find_or_create_by(title: "build website", user: User.last, public: true)

#makes user a collaborator if necessary, then creates items by each user for each list
if Item.count == 0
  List.all.each do |list|
    User.all.each do |user|
      if user != list.user
        FactoryGirl.create(:lists_user, list: list, user: user)
      end
      FactoryGirl.create(:item, list: list, user: user)
    end
  end
end
