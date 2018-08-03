class AddTeamIdsToFixtureTableAsForeignKey < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :fixtures, :teams, column: :home_team
    add_foreign_key :fixtures, :teams, column: :away_team
  end
end
