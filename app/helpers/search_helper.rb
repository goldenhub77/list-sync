module SearchHelper

  def object_type?(obj)
    return "" unless obj.present?
    begin
      if obj.class == Array
        type = obj.first.class.name
      else
        type = obj.class.name
      end
    rescue NoMethodError
      nil
    end
  end
end
