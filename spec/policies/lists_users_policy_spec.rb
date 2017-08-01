require 'rails_helper'

describe ListsUserPolicy do
  subject { described_class.new(user, list_collaboration) }

  context 'being a non-member' do
    let(:user) { FactoryGirl.create(:user) }
    let(:list_collaboration) { nil }

    it { is_expected.to forbid_action(:leave) }
  end

  context 'being a member/collaborator' do
    let(:user) { FactoryGirl.create(:user) }
    let(:list_collaboration) { FactoryGirl.create(:lists_user, user: user) }

    it { is_expected.to permit_action(:leave) }
  end
end
