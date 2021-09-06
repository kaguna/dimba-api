class UserMailer < ApplicationMailer
default from: 'notifications@chezadimba.co.ke'

  def welcome_email
    @user = params[:to]
    @url  = 'https://www.chezadimba.co.ke/login'
    mail(to: @user.email, subject: 'Welcome to Cheza Dimba')
  end
end