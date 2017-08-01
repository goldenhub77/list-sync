require 'rails_helper'

describe ListPolicy do
  subject { described_class.new(user, list) }

  let(:user) { FactoryGirl.create(:user) }
  let(:list) { FactoryGirl.create(:list) }


  context 'being a random visitor' do

    it { is_expected.to forbid_actions([:show, :edit, :update, :destroy]) }
  end

  context 'being a collaborator' do
    let(:list_collaboration) { FactoryGirl.create(:lists_user, user: user, list: list) }

    before(:each) do
      list_collaboration.reload
      user.reload
    end

    it { is_expected.to permit_action(:show) }
    it { is_expected.to forbid_actions([:edit, :update, :destroy]) }
  end

  context 'being an administrator' do
    let(:user) { FactoryGirl.create(:user, admin: true) }

    it { is_expected.to permit_actions([:show, :edit, :update, :destroy]) }
  end
end
