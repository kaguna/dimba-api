class RenameCommentaryForeignKeys < ActiveRecord::Migration[5.2]
  def up
    rename_column :commentaries, :fixtures_id, :fixture_id
    rename_column :commentaries, :events_id, :event_id
    rename_column :commentaries, :teams_id, :team_id
    rename_column :commentaries, :players_id, :player_id
  end

  def down
    rename_column :commentaries, :fixture_id, :fixtures_id
    rename_column :commentaries, :event_id, :events_id
    rename_column :commentaries, :team_id, :teams_id
    rename_column :commentaries, :player_id, :players_id
  end
end
