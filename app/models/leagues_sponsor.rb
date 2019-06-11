class LeaguesSponsor < ApplicationRecord
    belongs_to :leagues
    belongs_to :sponsors
end
