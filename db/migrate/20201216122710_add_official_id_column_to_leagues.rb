class AddOfficialIdColumnToLeagues < ActiveRecord::Migration[5.2]
  def change
    add_column :leagues, :official_id, :integer

    add_foreign_key :leagues, :users, column: :official_id
  end
end
