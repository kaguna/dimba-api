class AddForeignKeyToFixturesFromSeasons < ActiveRecord::Migration[5.2]
  def up
    add_foreign_key :fixtures, :seasons
  end

  def down
    remove_foreign_key :fixtures, :seasons
  end
end
