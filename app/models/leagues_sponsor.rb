class LeaguesSponsor < ApplicationRecord
    belongs_to :league
    belongs_to :sponsor
end
