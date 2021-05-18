class AddPlayerInSubstitution < ActiveRecord::Migration[5.2]
  def change
    add_column :commentaries, :player_in, :integer

    add_foreign_key :commentaries, :players, column: :player_in
  end
end
