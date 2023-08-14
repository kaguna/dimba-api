class AddLeagueStatusColumn < ActiveRecord::Migration[5.2]
  def change
    add_column :leagues, :active, :boolean, default: true
  end
end
