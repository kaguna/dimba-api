class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.integer :role_id
      t.string :password

      t.timestamps
    end
    add_foreign_key :users, :roles, column: :role_id
  end
end
