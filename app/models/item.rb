class Item < ApplicationRecord
  belongs_to :list

  validates :title, presence: true, uniqueness: { case_sensitive: false }
  validates :list_id, presence: true
end
