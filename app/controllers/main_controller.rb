class MainController < ApplicationController
  before_action :force_json, only: :autocomplete
  before_action :initialize_empty_search_variables, only: :search

  def welcome
  end

  def autocomplete
    if current_user.admin?
      @lists = List.all.ransack(title_cont: params[:q]).result(distinct: true).limit(10)
    else
      user_lists = current_user.lists.ransack(title_cont: params[:q]).result(distinct: true).limit(10)
      collabs = current_user.list_collaborations.ransack(title_cont: params[:q]).result(distinct: true).limit(10)
      pubs = List.public.ransack(title_cont: params[:q]).result(distinct: true).limit(10)
      @lists = (user_lists + collabs + pubs).uniq
    end
    @users = User.all_active_users.ransack(name_cont: params[:q]).result(distinct: true)
  end

  def search
    session[:q] = params['q'];
    if params['q'].present?
      if current_user.admin?
        @lists = List.all.ransack(title_cont: params[:q]).result(distinct: true)
      else
        user_lists = current_user.lists.ransack(title_cont: params[:q]).result(distinct: true)
        collabs = current_user.list_collaborations.ransack(title_cont: params[:q]).result(distinct: true)
        pubs = List.public.ransack(title_cont: params[:q]).result(distinct: true)
        @lists = (user_lists + collabs + pubs).uniq
      end
      @users = User.all_active_users.ransack(name_cont: params[:q]).result(distinct: true)
    else
      flash.now[:error] = "Please enter a search query."
    end
  end

  private

  def initialize_empty_search_variables
    @lists = []
    @users = []
  end

  def force_json
    request.format = :json
  end
end
