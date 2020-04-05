class LeaguesSponsor < ApplicationRecord
    validates :league, uniqueness: { scope: :sponsor }

    belongs_to :league
    belongs_to :sponsor
end
