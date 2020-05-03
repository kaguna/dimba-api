class AddColumnsToSeasonTable < ActiveRecord::Migration[5.2]
  def change
    add_column :seasons, :league_id, :integer
    add_column :seasons, :start_date, :integer
    add_column :seasons, :end_date, :integer

    add_foreign_key :seasons, :leagues
  end
end
