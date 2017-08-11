class ListMailer < ApplicationMailer

  def completed(list, user)
    @user = user
    @list = list
    @url = list_url(@list)
    mail(to: @user.email, subject: "Congratulations #{@list.title.titleize} has been completed")
  end
end
