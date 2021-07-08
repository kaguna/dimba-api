class AddCoachIdToTeams < ActiveRecord::Migration[5.2]
  def change
    add_column :teams, :coach_id, :integer

    add_foreign_key :teams, :users, column: :coach_id
  end
end
