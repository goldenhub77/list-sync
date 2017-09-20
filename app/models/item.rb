class Item < ApplicationRecord
  belongs_to :list
  belongs_to :user
  has_one :completed_lists_item
  has_one :completed_by, source: :user, through: :completed_lists_item, foreign_key: :user_id

  validates :title, presence: true, uniqueness: { case_sensitive: false }
  validates :list_id, presence: true
  validates :completed, inclusion: { in: [true, false] }
  validate :check_date_completed, :check_completed_by

  protected

  def check_date_completed
    if completed == false && date_completed.present?
      errors.add(:date_completed, "cannot be edited if item is not completed.")
    end
  end

  def check_completed_by
    if completed == true && completed_by.nil?
      errors.add(:list, "user is required when completing a item.")
    end
  end
end
