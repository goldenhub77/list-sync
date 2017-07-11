class List < ApplicationRecord
  has_many :items, dependent: :destroy

  validates :title, presence: true
  validates :public, inclusion: { in: [true, false] }
  validate :check_date_format, :due_date_greater_than_today?

  def self.public
    List.where('public = true')
  end

  protected

  def check_date_format
    return nil unless due_date_before_type_cast.present? && due_date_before_type_cast.class == String
    begin
      DateTime.parse(due_date_before_type_cast)
    rescue DateTime::ArgumentError
      errors.add(:due_date, "invalid")
    end
  end

  def due_date_greater_than_today?
    if due_date.present? && due_date < DateTime.now
      errors.add(:due_date, "cannot be less than current date and time")
    elsif due_date.nil?
      return nil
    else
      return true
    end
  end
end
