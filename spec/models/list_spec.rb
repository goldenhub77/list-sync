require 'rails_helper'

RSpec.describe List, type: :model do
  describe '.public' do
    it 'returns all lists that are public' do
      public_lists = List.public

      expect(public_lists).not_to include(public: false)
    end
  end
end
