class CreateSeasons < ActiveRecord::Migration[5.2]
  def change
    create_table :seasons do |t|
      t.string :name
      t.text :description
      t.integer :duration

      t.timestamps
    end
  end
end
