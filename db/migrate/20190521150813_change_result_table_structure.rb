class ChangeResultTableStructure < ActiveRecord::Migration[5.2]
  def up
    rename_column :results, :fixtures_id, :fixture_id
    rename_column :results, :total_goals, :home_goals
    rename_column :results, :points, :away_goals

    remove_column :results, :teams_id
  end

  def down
    rename_column :results, :fixture_id, :fixtures_id
    rename_column :results, :home_goals, :total_goals
    rename_column :results, :away_goals, :points

    add_column :results, :teams_id, :integer
  end
end
