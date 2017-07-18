class ListsUser < ApplicationRecord
  belongs_to :list
  belongs_to :user

  validates_presence_of :user_id, :list_id, :role
  validates :role, inclusion: { in: %w(member admin) }
  validates_uniqueness_of :list_id, scope: :user_id
end
