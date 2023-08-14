class DeactivateAccountMailer < ApplicationMailer
  default from: 'notifications@chezadimba.co.ke'

  def deactivate_account(user)
    created_at = user.created_at
    @dday = deactivation_day(created_at)
    @user = user
    @url  = "https://api.chezadimba.co.ke/api/v1/user/confirm_email"
    mail(to: @user.email, subject: "Account Activation Reminder")
  end

  private

  def deactivation_day(created_at)
    (created_at + Rails.application.config.unverified_grace_period).strftime("%A, %d %B %Y, at %I:%M %p")
  end
end