class ItemMailer < ApplicationMailer

  def create(item, user)
    @user = user
    @item = item
    @url = list_item_url(@item.list, @item)
    mail(to: @user.email, subject: "You created a new item for #{@item.list.title.titleize}")
  end
end
