class RenameRefereesToRefereeIds < ActiveRecord::Migration[5.2]
  def up
    rename_column :fixtures, :center_referee, :center_referee_id
    rename_column :fixtures, :right_side_referee, :right_side_referee_id
    rename_column :fixtures, :left_side_referee, :left_side_referee_id
  end

  def down
    rename_column :fixtures, :center_referee_id, :center_referee
    rename_column :fixtures, :right_side_referee_id, :right_side_referee
    rename_column :fixtures, :left_side_referee_id, :left_side_referee
  end
end
