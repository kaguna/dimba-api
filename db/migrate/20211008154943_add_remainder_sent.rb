class AddRemainderSent < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :email_reminder_sent, :boolean, :default => false
  end
end
