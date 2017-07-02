class ListsController < ApplicationController
  before_action :find_list, only: [:show, :edit, :update, :destroy]

  def index
    @lists = List.all.order("title DESC")
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
      flash.now[:error] = @list.errors.full_messages
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    @list.update_attributes(post_list_params)
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

  protected

  def find_list
    @list = List.find(get_list_params[:id])
  end

  def get_list_params
    params.permit(:id)
  end

  def post_list_params
    params.require(:list).permit(:title)
  end
end
