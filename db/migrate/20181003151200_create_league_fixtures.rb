class CreateLeagueFixtures < ActiveRecord::Migration[5.2]
  def change
    create_table :league_fixtures do |t|
      t.integer :league_id
      t.integer :match_id

      t.timestamps
    end
    add_foreign_key :league_fixtures, :leagues, column: :league_id
    add_foreign_key :league_fixtures, :fixtures, column: :match_id
  end
end
