module ListsHelper

  def time_left_until_due(end_date, start_date = DateTime.now)
    output = nil
    if end_date.present? && end_date > start_date
      output = 'Due in ' + distance_of_time_in_words(end_date - start_date)
    elsif end_date.present? && end_date < start_date
      output = 'Overdue'
    end
    output
  end

  def not_joined?(list)
    current_user.role(list).nil? && current_user != list.user
  end
end
