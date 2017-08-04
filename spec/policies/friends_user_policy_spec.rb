require 'rails_helper'

describe FriendsUserPolicy do
  subject { described_class.new(current_user, friends_user_record) }

  context 'being a random visitor' do
    let(:current_user) { FactoryGirl.create(:user) }
    let(:friend) { FactoryGirl.create(:user) }
    let(:friends_user_record) { FactoryGirl.create(:friends_user) }


    it { is_expected.to forbid_action(:remove) }
  end

  context 'removing a friend' do
    let(:current_user) { FactoryGirl.create(:user) }
    let(:friend) { FactoryGirl.create(:user) }
    let(:friends_user_record) { FactoryGirl.create(:friends_user, user: current_user, friend: friend) }

    it { is_expected.to permit_action(:remove) }
  end
end
