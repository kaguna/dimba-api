class CreateTeams < ActiveRecord::Migration[5.2]
  def change
    create_table :teams do |t|
      t.string :name
      t.text :description
      t.text :location
      t.text :nickname

      t.timestamps
    end
  end
end
