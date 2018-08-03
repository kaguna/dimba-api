class AddTeamIdAsForeignKey < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :players, :teams
  end
end
