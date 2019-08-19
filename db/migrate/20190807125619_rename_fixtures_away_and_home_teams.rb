class RenameFixturesAwayAndHomeTeams < ActiveRecord::Migration[5.2]
  def up
    rename_column :fixtures, :home_team, :home_team_id
    rename_column :fixtures, :away_team, :away_team_id
  end

  def down
    rename_column :fixtures, :home_team_id, :home_team
    rename_column :fixtures, :away_team_id, :away_team
  end
end
