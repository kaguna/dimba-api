class AddRoleIdAsForeignKeyInUsersTable < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :role, :role_id
    add_foreign_key :users, :roles, column: :role_id
  end
end
