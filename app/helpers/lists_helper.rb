module ListsHelper

  def time_to_s(date_obj)
    begin
      date_obj.strftime("%Y-%m-%dT%H:%M+00:00")
    rescue DateTime::ArgumentError, DateTime::NoMethodError, DateTime::TypeError => message
      nil
    end
  end

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
