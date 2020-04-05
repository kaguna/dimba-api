class ChangeMatchDayToDateTimeFormat < ActiveRecord::Migration[5.2]
  def up
    change_column :fixtures, :match_day, :datetime 
  end

  def down
    change_column :fixtures, :match_day, :date
  end
end
