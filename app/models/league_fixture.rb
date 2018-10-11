class LeagueFixture < ApplicationRecord
  belongs_to :league
  belongs_to :fixture, foreign_key: :match_id
end
