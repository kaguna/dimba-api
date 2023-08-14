class LeaguesTeam < ApplicationRecord
  belongs_to :team
  belongs_to :league
  belongs_to :season

  validates :team, uniqueness: { scope: [:league_id, :season_id],
    message:  "should be in a league once per season" }

  scope :league_season_teams, ->(league_id:, season_id:) { where(league_id: league_id, season_id: season_id) }
end
