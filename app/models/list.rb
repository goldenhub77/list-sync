include ActionView::Helpers::DateHelper
class List < ApplicationRecord
  has_many :items, dependent: :destroy

  validates :title, presence: true
  validates :public, inclusion: { in: [true, false] }
  validate :check_date_format, :due_date_greater_than_today

  def local_time
    if !due_date.present?
      nil
    else
      date_obj = DateTime.parse(due_date)
      Time.local(date_obj.year, date_obj.month, date_obj.day, date_obj.hour, date_obj.min)
    end
  end

  def time_to_s
    return nil unless due_date.present?
    begin
      DateTime.parse(due_date).strftime("%m/%d/%Y %I:%M %p")
    rescue DateTime::ArgumentError, DateTime::TypeError
      due_date
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

  def date_invalid?
    return false unless due_date.present?
    date_format = /^(\d{2}\/\d{2}\/\d{4} \d{2}:\d{2}) (AM|PM)$/
    date_format.match(time_to_s).nil?
  end

  def check_date_format
    if date_invalid?
      errors.add(:due_date, "invalid")
    end
  end

  def due_date_greater_than_today
    return nil if date_invalid?
    if due_date.present? && local_time < DateTime.now
      errors.add(:due_date, "cannot be less than current date and time")
    end
  end
end
