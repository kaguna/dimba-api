namespace :app do
  desc "Send reminder emails"
  task :send_reminders => [:environment] do
    p "Start: #{Time.now}"
    User.where("email_confirmed = ? AND email_reminder_sent = ? AND created_at <= ?", 
      false, false, Rails.application.config.unverified_reminder.ago)
      .find_each do |user|
        user.account_deactivation_warning!
    end
    p "Done! #{Time.now}"
  end
end
