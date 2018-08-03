class CreateResults < ActiveRecord::Migration[5.2]
  def change
    create_table :results do |t|
      t.references :teams, foreign_key: true
      t.references :fixtures, foreign_key: true
      t.integer :total_goals
      t.integer :points

      t.timestamps
    end
  end
end
