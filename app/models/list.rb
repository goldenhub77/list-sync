include ActionView::Helpers::DateHelper
class List < ApplicationRecord
  has_many :items, dependent: :destroy

  validates :title, presence: true
  validates :public, inclusion: { in: [true, false] }
  validate :check_date_format, :due_date_greater_than_today

  def time_left
    if due_date.present? && due_date > DateTime.now
      distance_of_time_in_words_to_now(due_date)
    elsif due_date.present? && due_date < DateTime.now
      "Overdue"
    else
      "No Due Date"
    end
  end

  def self.public
    List.where('public = true')
  end

  protected

  def check_date_format
    return nil unless due_date.present? && due_date_before_type_cast.class != Time
    begin
      DateTime.parse(due_date_before_type_cast)
    rescue DateTime::ArgumentError
      errors.add(:due_date, "invalid")
    end
  end

  def due_date_greater_than_today
    if due_date.present? && due_date < DateTime.now
      errors.add(:due_date, "cannot be less than current date and time")
    end
  end
end
