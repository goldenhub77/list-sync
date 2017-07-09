require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the ListsHelper. For example:
#
# describe ListsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe ListsHelper, type: :helper do

  before(:each) do
    one_hour_ahead = DateTime.now + 1.hour
    FactoryGirl.create(:list, public: true, due_date: one_hour_ahead.strftime)
    FactoryGirl.create(:list, public: true)
  end

  describe '.time_left_until_due' do
    it 'returns remaining time if due date specified' do
      list_with_date = List.first
      list_overdue = List.first
      list_overdue.due_date = DateTime.now - 1.hour
      list_no_date = List.second

      expect(time_left_until_due(list_no_date.due_date)).to eq("No Due Date")
      expect(time_left_until_due(list_with_date.due_date)).to eq("about 1 hour")
      expect(time_left_until_due(list_overdue.due_date)).to eq("Overdue")
    end
  end

  describe '.time_to_s' do
    it 'returns UTC date object to string as ex "2017-03-20T13:30+00:00"' do
      utc_date = DateTime.parse("2017-07-09T13:30:00-04:00").utc
      invalid_utc_date = "2017-07-09T13:30:00-04:00"

      expect(time_to_s(utc_date)).to eq("2017-07-09T17:30+00:00")
      expect(time_to_s(invalid_utc_date)).to eq(nil)
    end
  end
end
