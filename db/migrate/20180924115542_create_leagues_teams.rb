class CreateLeaguesTeams < ActiveRecord::Migration[5.2]
  def change
    create_table :leagues_teams do |t|
      t.integer :team_id
      t.integer :league_id

      t.timestamps
    end
  end
end
