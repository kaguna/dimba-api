class AddSeasonScorers < ActiveRecord::Migration[5.2]
  def change
    add_column :season_standings, :scorers, :text, default: nil
  end
end
