class AddAssociationBetweenLeagueAndSponsorTable < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :leagues_sponsors, :sponsors, column: :sponsor_id
    add_foreign_key :leagues_sponsors, :leagues, column: :league_id
  end
end
