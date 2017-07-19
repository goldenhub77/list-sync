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

  describe '.role(user)', %{
    This is only for checking the role of a particular collaborator for the list being called.
    The argument has to be a user_id or user object
    } do


    let(:user) { User.first }
    let(:list) { FactoryGirl.create(:list, user_id: user.id) }
    let(:list_collaboration) { FactoryGirl.create(:lists_user, user_id: user.id, list_id: list.id) }


    it 'returns nil if NoMethodError or RecordNotFound' do
      user_bad_type = "string"
      user_no_record = 0

      expect(list.collaborators).to eq([])
      expect(list.role(user_bad_type)).to eq(nil)
      expect(list.role(user_no_record)).to eq(nil)
    end

    it 'returns either "member" or "admin" depending on user role for particular list' do
      list_collaboration.reload
      user.reload
      list.reload

      expect(list.collaborators).not_to be_empty
      expect(list.role(user)).to eq('member')
    end
  end
end
