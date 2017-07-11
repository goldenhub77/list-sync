module ListsHelper

  def time_left_until_due(end_date, start_date = DateTime.now)
    if end_date.present? && end_date > start_date
      distance_of_time_in_words(end_date - start_date)
    elsif end_date.present? && end_date < start_date
      "Overdue"
    else
      "No Due Date"
    end
  end
end
