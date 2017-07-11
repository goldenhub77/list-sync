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
RSpec.describe ApplicationHelper, type: :helper do

  before(:each) do
    one_hour_ahead = DateTime.now + 1.hour
    FactoryGirl.create(:list, public: true, due_date: one_hour_ahead.strftime)
    FactoryGirl.create(:list, public: true)
  end

  describe '.format_date_to_ISO' do
    it 'returns ISO compliant format date for browser compatibility date object will look like example "2017-03-20T13:30+00:00"' do
      utc_date = DateTime.parse("2017-07-09T13:30:00-04:00").utc
      invalid_utc_date = "2017-07-09T13:30:00-04:00"

      expect(format_date_to_ISO(utc_date)).to eq("2017-07-09T17:30+00:00")

    end

    it 'returns nil if invalid input such as a string' do
      invalid_utc_date = "2017-07-09T13:30:00-04:00"

      expect(format_date_to_ISO(invalid_utc_date)).to eq(nil)
    end
  end
end
