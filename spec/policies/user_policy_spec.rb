require 'rails_helper'

describe UserPolicy do
  subject { described_class.new(current_user, user_record) }

  let(:list) { FactoryGirl.create(:list, public: true) }


  context 'being a random visitor' do
    let(:current_user) { FactoryGirl.create(:user) }
    let(:user_record) { FactoryGirl.create(:user) }

    it { is_expected.to forbid_action(:collaborations) }
  end

  context 'being a collaborator' do
    let(:current_user) { FactoryGirl.create(:user) }
    let(:user_record) { current_user }

    it { is_expected.to permit_action(:collaborations) }
  end

  context 'being an administrator' do
    let(:current_user) { FactoryGirl.create(:user, admin: true) }
    let(:user_record) { FactoryGirl.create(:user) }

    it { is_expected.to permit_action(:collaborations) }
  end
end
