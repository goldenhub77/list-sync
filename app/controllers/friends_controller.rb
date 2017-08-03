class FriendsController < ApplicationController
  before_action :find_user

  def index
    if @user == current_user
      @title = "My Friends"
    else
      @title = "#{@user.name}'s (#{@user.email}) Friends"
    end
    @friends = @user.friends
  end

  def show

  end

  protected

  def find_user
    if get_user_params[:user_id].present? || get_user_params[:id].present?
      @user = User.find(get_user_params[:user_id] ||= get_user_params[:id])
    else
      @user = current_user
    end
    authorize(@user)
  end

  def get_user_params
    params.permit(:id, :user_id)
  end

end
