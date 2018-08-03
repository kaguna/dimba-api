class CreateFixtures < ActiveRecord::Migration[5.2]
  def change
    create_table :fixtures do |t|
      t.integer :home_team
      t.integer :away_team
      t.text :season
      t.date :match_day

      t.timestamps
    end
  end
end
