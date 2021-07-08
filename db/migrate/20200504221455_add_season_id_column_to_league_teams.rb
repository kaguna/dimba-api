class AddSeasonIdColumnToLeagueTeams < ActiveRecord::Migration[5.2]
  def change
    add_column :leagues_teams, :season_id, :integer

    add_foreign_key :leagues_teams, :seasons
  end
end
