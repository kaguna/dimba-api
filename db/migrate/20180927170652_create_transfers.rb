class CreateTransfers < ActiveRecord::Migration[5.2]
  def change
    create_table :transfers do |t|
      t.integer :from_team_id
      t.integer :to_team_id
      t.integer :player_id
      t.text :transfer_comment
      t.float :transfer_budget
      t.text :contract_time

      t.timestamps
    end
    add_foreign_key :transfers, :teams, column: :from_team_id
    add_foreign_key :transfers, :teams, column: :to_team_id
    add_foreign_key :transfers, :players, column: :player_id
  end
end
