require 'rails_helper'

RSpec.describe List, type: :model do

  before(:each) do
    one_hour_ahead = DateTime.now + 1.hour
    FactoryGirl.create(:list, public: true, due_date: one_hour_ahead.strftime)
    FactoryGirl.create(:list, public: true)
  end

  describe '.public' do
    it 'returns all lists that are public' do
      public_lists = List.public
      expect(public_lists.count).to eq(2)
      public_lists.each do |list|
        expect(list.public).not_to eq(false)
        expect(list.public).to eq(true)
      end
    end
  end

  describe '.time_left' do
    it 'returns remaining time if due date specified' do
      list_with_date = List.first
      list_overdue = List.first
      list_overdue.due_date = DateTime.now - 1.hour
      list_no_date = List.second

      expect(list_no_date.time_left).to eq("No Due Date")
      expect(list_with_date.time_left).to eq("about 1 hour")
      expect(list_overdue.time_left).to eq("Overdue")
    end
  end
end
