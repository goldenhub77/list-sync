class FriendsController < ApplicationController
  before_action :find_user
  before_action :find_friend, only: [:add, :remove]
  before_action :find_friendship, only: :remove

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

  def add
    @friendship = @user.friends_users.create(post_friend_params)
    if @friendship.valid?
      flash[:notice] = "You are now friends with #{@friend.name}"
    end
    redirect_to request.referrer
  end

  def remove
    @friendship.destroy
    if @friendship.valid?
      flash[:notice] = "You are no longer friends with #{@friend.name}"
    end
    redirect_to request.referrer
  end

  protected

  def find_user
    if post_friend_params[:user_id].present? || post_friend_params[:id].present?
      @user = User.find(post_friend_params[:user_id] ||= post_friend_params[:id])
    else
      @user = current_user
    end
    authorize(@user, :lists?)
  end

  def find_friend
    @friend = User.find(post_friend_params[:friend_id])
  end

  def find_friendship
    @friendship = @user.friends_users.where(post_friend_params).first
    authorize(@friendship)
  end

  def post_friend_params
    params.permit(:id, :user_id, :friend_id)
  end

end
