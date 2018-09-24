class AddForeignKeys < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :leagues, :leagues_teams, column: :leagues_teams_id
    add_foreign_key :leagues_teams, :teams, column: :team_id
  end
end
