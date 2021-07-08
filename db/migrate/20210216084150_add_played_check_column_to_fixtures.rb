class AddPlayedCheckColumnToFixtures < ActiveRecord::Migration[5.2]
  def change
    add_column :fixtures, :played, :boolean, default: false
  end
end
