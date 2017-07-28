class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  before_action :authenticate_user!, except: :welcome
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :disable_cache_headers
  before_action :set_custom_pundit_scopes, if: :main_controller?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore

    flash[:error] = t "#{policy_name}.#{exception.query}", scope: "pundit", default: :default
    redirect_to(request.referrer || root_path)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :profile_picture, :admin])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :profile_picture, :admin])
  end

  #resolves notifications from persisting when utiltizing browser back or forward buttons
  def disable_cache_headers
    response.headers["Cache-Control"] = "no-cache, no-store"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end

  def set_custom_pundit_scopes
    @search_lists = MainPolicy::ListScope.new(current_user, List).resolve
    @search_users = MainPolicy::UserScope.new(current_user, User).resolve
  end

  def main_controller?
    controller_path == "main" && action_name != 'welcome'
  end
end
