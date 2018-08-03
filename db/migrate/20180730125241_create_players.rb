class CreatePlayers < ActiveRecord::Migration[5.2]
  def change
    create_table :players do |t|
      t.string :first_name
      t.string :second_name
      t.string :last_name
      t.string :nick_name
      t.text :id_number
      t.date :dob
      t.text :phone_number
      t.integer :team_id

      t.timestamps
    end
  end
end
