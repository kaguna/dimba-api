class CreateSeasonStanding < ActiveRecord::Migration[5.2]
  def change
    create_table :season_standings do |t|
      t.integer :season_id
      t.text :standing

      t.timestamps
    end
    add_foreign_key :season_standings, :seasons, column: :season_id
  end
end
