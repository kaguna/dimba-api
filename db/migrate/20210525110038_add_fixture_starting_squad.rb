class AddFixtureStartingSquad < ActiveRecord::Migration[5.2]
  def change
    add_column :fixture_squads, :starting, :boolean, default: false
  end
end
