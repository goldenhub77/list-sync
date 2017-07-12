module DeviseHelper
  def devise_error_messages!
    return nil unless devise_error_messages?
    resource.errors.full_messages
  end

  def devise_error_messages?
    !resource.errors.empty?
  end
end
