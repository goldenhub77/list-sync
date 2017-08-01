class ListsController < ApplicationController
  before_action :find_list, only: [:show, :edit, :update, :destroy, :join, :leave]
  before_action :find_user, except: [:index]
  before_action :collaboration_present?, only: [:leave]

  def index
    @lists = policy_scope(List)
  end

  def new
    @list = List.new
  end

  def create
    @list = List.create(post_list_params)
    if @list.valid?
      flash[:notice] = "Created List Successfully."
      redirect_to list_path(@list)
    else
      render :new
    end
  end

  def show
    @items = @list.items.order("date_completed DESC, created_at DESC")
  end

  def edit
  end

  def update
    @list.update(post_list_params)
    if @list.valid?
      flash[:notice] = "Updated List Successfully."
      redirect_to list_path(@list)
    else
      flash.now[:error] = @list.errors.full_messages
      render :edit
    end
  end

  def destroy
    if @list.destroy
      flash[:notice] = "Deleted List Successfully."
      redirect_to lists_path
    else
      redirect_to list_path(@list)
    end
  end

  def join
    @list_collaboration = ListsUser.create(join_params)
    if @list_collaboration.valid?
      flash[:notice] = "Joined List Successfully."
      redirect_to list_path(@list)
    else
      redirect_to lists_path
    end
  end

  def leave
    # @list_collaboration = @user.lists_users.where(join_params).first
    @list_collaboration.destroy
    if @list_collaboration.valid?
      flash[:notice] = "Left List Successfully."
      redirect_to list_path(@list)
    else
      redirect_to lists_path
    end
  end

  protected

  def find_list
    @list = List.find(get_list_params[:id] ||= join_params[:list_id])
    authorize(@list)
  end

  def find_user
    if get_list_params[:user_id].present?
      @user = User.find(get_list_params[:user_id])
    else
      @user = current_user
    end
    # authorize(@user)
  end

  def collaboration_present?
    @list_collaboration = @user.lists_users.where(join_params).first
    if @list_collaboration.present?
      authorize(@list_collaboration)
    else
      flash[:notice] = "You created or have not joined this list."
      redirect_to list_path(@list)
    end
  end

  def get_list_params
    params.permit(:id, :user_id)
  end

  def post_list_params
    params.require(:list).permit(:title, :public, :due_date, :user_id)
  end

  def join_params
    params.permit(:user_id, :list_id)
  end
end
