class ChangeSeasonIdFromStringToInteger < ActiveRecord::Migration[5.2]
  def up
    change_column :fixtures, :season, 'integer USING CAST(season AS integer)'
  end

  def down
    change_column :fixtures, :season, :string
  end
end
