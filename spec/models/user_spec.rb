require 'rails_helper'

RSpec.describe User, type: :model do

  before(:each) do
    FactoryGirl.create(:user)
  end

  describe '.password_complexity' do
    it 'returns nil if provider present' do
      user = User.first
      user.provider = "facebook"
      user.save

      expect(user.password_complexity).to eq(nil)
      expect(user.errors.full_messages).to eq([])
    end

    it 'adds password error to active record resource' do
      user = User.first
      user.password = "badpassword"
      user.save
      expect(user.password_complexity).to include("must include at least one lowercase letter, one uppercase letter, one digit, and one symbol")
      expect(user.errors.full_messages).to include("Password must include at least one lowercase letter, one uppercase letter, one digit, and one symbol")
    end
  end

  describe '.role(list)', %{
    This is only for checking the role of a particular user for the list being called.
    The argument has to be a list_id or list object
    } do

    let(:user) { User.first }
    let(:list) { FactoryGirl.create(:list, user_id: user.id) }
    let(:list_collaboration) { FactoryGirl.create(:lists_user, user_id: user.id, list_id: list.id) }

    it 'returns nil if invalid input or no list_collaborations' do
      list_bad_type = "string"
      list_no_record = 0

      expect(user.list_collaborations).to eq([])
      expect(user.role(list_bad_type)).to eq(nil)
      expect(user.role(list_no_record)).to eq(nil)
    end

    it 'returns either "member" or "admin" depending on user role for particular list' do
      list_collaboration.reload
      list.reload
      user.reload

      expect(user.list_collaborations).not_to be_empty
      expect(user.role(list)).to eq('member')
    end
  end
end
