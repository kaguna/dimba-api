class LeaguesTeam < ApplicationRecord
  validates :team, uniqueness: { scope: :league }

  belongs_to :team
  belongs_to :league
end
