class MainController < ApplicationController
  before_action :force_json, only: :autocomplete

  def welcome
  end

  def autocomplete
    @lists = List.ransack(title_cont: params[:q]).result(distinct: true).limit(5)
    @users = User.ransack(name_or_email_cont: params[:q]).result(distinct: true).limit(5)
  end

  def search
    session[:q] = params['q'];
    @lists = List.ransack(title_cont: params[:q]).result(distinct: true)
    @users = User.ransack(name_or_email_cont: params[:q]).result(distinct: true)
  end

  private

  def force_json
    request.format = :json
  end
end
