class CreateFixtures < ActiveRecord::Migration[5.2]
  def change
    create_table :fixtures do |t|
      t.integer :home_team
      t.integer :away_team
      t.integer :league_id
      t.integer :center_referee
      t.integer :right_side_referee
      t.integer :left_side_referee
      t.text :season
      t.date :match_day

      t.timestamps
    end
  end
end
