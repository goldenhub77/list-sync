class ItemMailer < ApplicationMailer

  def create(item, user)
    @user = user
    @item = item
    @url = list_item_url(@item.list, @item)
    mail(to: @user.email, subject: "You created a new item for #{@item.list.title.titleize}")
  end

  def completed(item, user)
    @user = user
    @item = item
    if @item.date_completed.present?
      @status = 'completed'
    else
      @status = 'incompleted'
    end
    @url = list_item_url(@item.list, @item)
    mail(to: @user.email, subject: "You #{@status} item for #{@item.list.title.titleize}")
  end
end
