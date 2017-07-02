class ListsController < ApplicationController

  def index
    @lists = List.all
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
    @list = List.find(get_list_params[:id])
  end

  protected

  def get_list_params
    params.permit(:id)
  end

  def post_list_params
    params.require(:list).permit(:title)
  end
end
