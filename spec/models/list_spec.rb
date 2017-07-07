require 'rails_helper'

RSpec.describe List, type: :model do

  before(:each) do
    FactoryGirl.create(:list, public: true, due_date: DateTime.parse("2017-08-01T22:00:00"))
    FactoryGirl.create(:list, public: true, due_date: DateTime.now - 36.hours)
    FactoryGirl.create(:list, public: true)
  end

  describe '.public' do
    it 'returns all lists that are public' do
      public_lists = List.public
      expect(public_lists.count).to eq(3)
      public_lists.each do |list|
        expect(list.public).not_to eq(false)
        expect(list.public).to eq(true)
      end
    end
  end

  describe '.time_left' do
    it 'returns remaining time if due date specified' do
      list_with_date = List.first
      list_overdue = List.second
      list_no_date = List.third

      expect(list_no_date.time_left).to eq("No Due Date")
      expect(list_with_date.time_left).to eq("26 days")
      expect(list_overdue.time_left).to eq("Overdue")
    end
  end

  describe '.local_time' do
    it 'returns local time with no time zone offset if due date specified' do
      list_with_date = List.first
      list_no_date = List.third
      expect(list_no_date.local_time).to eq(nil)
      expect(list_with_date.local_time).to eq("2017-08-01 22:00:00 -0400")
    end
  end
end
