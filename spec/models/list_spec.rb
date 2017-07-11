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

  describe '.check_date_format' do
    it 'returns DateTime object if argument is a valid string is a proper format for parsing' do
      list = List.first
      expect(list.send(:check_date_format)).to be_a_kind_of(DateTime)
    end

    it 'returns errors "invalid" to active record if Argument error found' do
      list = List.first
      list.due_date = "this is bad"
      expect(list.send(:check_date_format)).to eq(["invalid"])
    end

    it 'returns nil if no due_date exists for List' do
      list = List.second
      expect(list.send(:check_date_format)).to eq(nil)
    end
  end

  describe '.due_date_greater_than_today?' do
    it 'returns true if argument is a valid Date object and greater than todays date' do
      list = List.first
      expect(list.send(:due_date_greater_than_today?)).to eq(true)
    end

    it 'returns errors "cannot be less than current date and time" to active record if Date present and less than todays date' do
      list = List.first
      list.due_date -= 1.hour
      expect(list.send(:due_date_greater_than_today?)).to eq(["cannot be less than current date and time"])
    end

    it 'returns nil if no due_date exists for List' do
      list = List.second
      expect(list.send(:due_date_greater_than_today?)).to eq(nil)
    end
  end
end
