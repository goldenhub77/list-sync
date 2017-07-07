include ActionView::Helpers::DateHelper
class List < ApplicationRecord
  has_many :items, dependent: :destroy

  validates :title, presence: true
  validates :public, inclusion: { in: [true, false] }


  def local_time
    if self.due_date
      Time.local(self.due_date.year, self.due_date.month, self.due_date.day, self.due_date.hour, self.due_date.min)
    else
      nil
    end
  end

  def time_left
    if due_date.present? && self.local_time > DateTime.now
      distance_of_time_in_words_to_now(self.local_time)
    elsif due_date.present? && self.local_time < DateTime.now
      "Overdue"
    else
      "No Due Date"
    end
  end

  def self.public
    List.where('public = true')
  end

  protected

  def due_date_greater_than_today
    if due_date.present? && due_date < DateTime.now
      errors.add(:due_date, "cannot be less than current date and time")
    end
  end
end
