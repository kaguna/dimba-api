class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.text :event_time
      t.references :teams, foreign_key: true
      t.references :players, foreign_key: true
      t.references :fixtures, foreign_key: true

      t.timestamps
    end
  end
end
