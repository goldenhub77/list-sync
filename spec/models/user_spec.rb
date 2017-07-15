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
end
