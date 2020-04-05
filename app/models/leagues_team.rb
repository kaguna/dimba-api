class LeaguesTeam < ApplicationRecord
  belongs_to :team
  belongs_to :league

  validates :team, uniqueness: { scope: :league_id,
    message:  "should be in a league once" }
end
