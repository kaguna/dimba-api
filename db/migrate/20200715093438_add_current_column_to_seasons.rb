class AddCurrentColumnToSeasons < ActiveRecord::Migration[5.2]
  def change
    add_column :seasons, :current, :boolean, default: true
  end
end
