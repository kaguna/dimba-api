class SendResetPasswordTokenMailer < ApplicationMailer
  default from: 'notifications@chezadimba.co.ke'

  def send_reset_password_token(user)
    @user = user
    @url  = 'https://www.chezadimba.co.ke/show-password-reset-form'
    mail(to: @user.email, subject: 'Reset Password')
  end
end
