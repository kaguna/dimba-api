class ChangeFixturesSeasonNameToId < ActiveRecord::Migration[5.2]
  def up
    rename_column :fixtures, :season, :season_id
  end

  def down
    rename_column :fixtures, :season_id, :season
  end
end
