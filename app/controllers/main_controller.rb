class MainController < ApplicationController
  before_action :force_json, only: :autocomplete
  before_action :initialize_search_variables, only: :search

  def welcome
  end

  def autocomplete
    #MainPolicy::ListScope and UserScope are custom pundit scopes to handle returning requests that the current_user should have access to
    @lists = @search_lists.ransack(title_cont: params[:q]).result(distinct: true).limit(5)
    @users = @search_users.ransack(name_cont: params[:q]).result(distinct: true).limit(5)
  end

  def search
    session[:q] = params['q'];
    #MainPolicy::ListScope and UserScope are custom pundit scopes to handle returning requests that the current_user should have access to
    if params['q'].present?
      @lists = @search_lists.ransack(title_cont: params[:q]).result()
      @users = @search_users.ransack(name_cont: params[:q]).result()
    else
      flash.now[:error] = "Please enter a search query."
    end
  end

  private

  def initialize_search_variables
    @lists = []
    @users = []
  end

  def force_json
    request.format = :json
  end
end
