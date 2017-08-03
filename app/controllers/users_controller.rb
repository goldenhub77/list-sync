class UsersController < ApplicationController
  before_action :find_user

  def index
    @users = policy_scope(User)
  end

  def show
  end

  def collaborations
    if @user == current_user
      @title = "My Collaborations"
    else
      @title = "#{@user.name}'s (#{@user.email}) Collaborations"
    end
    @collaborations = @user.list_collaborations
  end

  def lists
    if current_user.admin? || current_user == @user
      @lists = @user.lists.order("title DESC")
    else
      redirect_to lists_path
    end
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
