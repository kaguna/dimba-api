class CreateFixtureSquads < ActiveRecord::Migration[5.2]
  def change
    create_table :fixture_squads do |t|
      t.references :players, foreign_key: true
      t.boolean :playing, default: true
      t.references :fixtures, foreign_key: true
      t.references :teams, foreign_key: true

      t.timestamps
    end
  end
end
