class CreateLeagues < ActiveRecord::Migration[5.2]
  def change
    create_table :leagues do |t|
      t.text :title
      t.text :season

      t.timestamps
    end
  end
end
