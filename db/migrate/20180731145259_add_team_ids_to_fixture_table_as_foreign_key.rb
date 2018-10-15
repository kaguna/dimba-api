class AddTeamIdsToFixtureTableAsForeignKey < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :fixtures, :teams, column: :home_team
    add_foreign_key :fixtures, :teams, column: :away_team
    add_foreign_key :fixtures, :leagues, column: :league_id
    add_foreign_key :fixtures, :users, column: :center_referee
    add_foreign_key :fixtures, :users, column: :right_side_referee
    add_foreign_key :fixtures, :users, column: :left_side_referee
  end
end
