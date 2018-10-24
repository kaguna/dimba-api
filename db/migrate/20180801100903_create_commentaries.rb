class CreateCommentaries < ActiveRecord::Migration[5.2]
  def change
    create_table :commentaries do |t|
      t.references :events, foreign_key: true
      t.text :description
      t.text :commentary_time
      t.references :teams, foreign_key: true
      t.references :players, foreign_key: true
      t.references :fixtures, foreign_key: true

      t.timestamps
    end
  end
end
