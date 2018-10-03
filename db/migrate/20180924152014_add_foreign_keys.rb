class AddForeignKeys < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :leagues_teams, :leagues, column: :league_id
    add_foreign_key :leagues_teams, :teams, column: :team_id
  end
end
