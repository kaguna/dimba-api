class CreateSponsors < ActiveRecord::Migration[5.2]
  def change
    create_table :sponsors do |t|
      t.text :name
      t.text :description
      t.text :contacts

      t.timestamps
    end
  end
end
