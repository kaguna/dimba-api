class ChangeResultTableStructure < ActiveRecord::Migration[5.2]
  def change
    rename_column :results, :fixtures_id, :fixture_id
    rename_column :results, :total_goals, :home_goals
    rename_column :results, :points, :away_goals

    remove_column :results, :teams_id

    add_foreign_key :results, :fixtures
  end
end
