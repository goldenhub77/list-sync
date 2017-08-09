class UserMailer < ApplicationMailer

  def welcome(user)
    @user = user
    @url = 'https://lystsync.herokuapp.com'
    mail(to: @user.email, subject: 'Welcome to LystSync')
  end
end
