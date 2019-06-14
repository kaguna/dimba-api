class FixtureSquad < ApplicationRecord
  validates_presence_of :fixture_id,
                        :player_id,
                        :team_id
end
