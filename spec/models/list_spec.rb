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
end
