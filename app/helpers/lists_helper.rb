module ListsHelper

  def time_to_s(date_obj)
    begin
      date_obj.strftime("%Y-%m-%dT%H:%M+00:00")
    rescue DateTime::ArgumentError, DateTime::NoMethodError, DateTime::TypeError => message
      nil
    end
  end
end
