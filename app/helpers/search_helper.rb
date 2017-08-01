module SearchHelper

  def object_type?(obj)
    return nil unless obj.present?
    begin
      if obj.class == Array
        type = obj.first.class.name
      else
        type = obj.class.name
      end
    rescue NoMethodError
      return nil
    end
  end
end
