class RenameFixtureSquadForeignKeys < ActiveRecord::Migration[5.2]
  def up
    rename_column :fixture_squads, :fixtures_id, :fixture_id
    rename_column :fixture_squads, :teams_id, :team_id
    rename_column :fixture_squads, :players_id, :player_id
  end

  def down
    rename_column :fixture_squads, :fixture_id, :fixtures_id
    rename_column :fixture_squads, :team_id, :teams_id
    rename_column :fixture_squads, :player_id, :players_id
  end
end
