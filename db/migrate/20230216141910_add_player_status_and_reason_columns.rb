class AddPlayerStatusAndReasonColumns < ActiveRecord::Migration[5.2]
  def change
    add_column :players, :active, :boolean, :default => true
    add_column :players, :status_reason, :integer, :default => nil
  end
end
