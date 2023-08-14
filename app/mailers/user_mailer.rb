class UserMailer < ApplicationMailer
  default from: 'notifications@chezadimba.co.ke'

  def registration_confirmation
    @user = params[:to]
    @url  = "https://api.chezadimba.co.ke/api/v1/user/confirm_email"
    mail(to: @user.email, subject: "Registration Confirmation")
  end

  def welcome_email(user)
    @url  = 'https://www.chezadimba.co.ke/login'
    mail(to: user.email, subject: 'Welcome to Cheza Dimba')
  end
end