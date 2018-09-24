class CreateLeagues < ActiveRecord::Migration[5.2]
  def change
    create_table :leagues do |t|
      t.text :title
      t.text :season
      t.integer :leagues_teams_id
      t.integer :sponsor_id

      t.timestamps
    end
  end
end
