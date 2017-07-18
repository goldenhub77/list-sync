class Item < ApplicationRecord
  belongs_to :list
  belongs_to :user
  belongs_to :creator, class_name: :User, foreign_key: :user_id

  validates :title, presence: true, uniqueness: { case_sensitive: false }
  validates :list_id, presence: true
  validates :completed, inclusion: { in: [true, false] }
  validate :check_date_completed

  protected

  def check_date_completed
    if completed == false && date_completed.present?
      errors.add(:date_completed, "cannot be edited if item is not completed.")
    end
  end
end
