class FixtureSquad < ApplicationRecord
  validates_presence_of :fixtures_id,
                        :players_id,
                        :teams_id
end
