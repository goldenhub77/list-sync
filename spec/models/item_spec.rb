require 'rails_helper'

RSpec.describe Item, type: :model do

  before(:each) do
    FactoryGirl.create(:list, public: true)
    FactoryGirl.create(:item)
    FactoryGirl.create(:item, completed: true, date_completed: DateTime.now)
  end

  describe '.check_date_completed' do
    it 'return nil as long as date_completed is nil when completed is false' do
      item = Item.first
      item_completed = Item.second
      expect(item.send(:check_date_completed)).to eq(nil)
      expect(item_completed.send(:check_date_completed)).to eq(nil)
    end

    it 'return ["cannot be edited if item is not completed."] as long as completed is false while trying to set a date_completed' do
      item_completed = Item.second
      item_completed.completed = false
      expect(item_completed.send(:check_date_completed)).to eq(["cannot be edited if item is not completed."])
    end
  end
end
