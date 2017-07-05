class List < ApplicationRecord
  has_many :items, dependent: :destroy

  validates :title, presence: true
  validates :public, inclusion: { in: [true, false] }

  def self.public
    List.where('public = true')
  end
end
