class ListsUser < ApplicationRecord
  belongs_to :list
  belongs_to :user

  validates_presence_of :user_id, :list_id
end
