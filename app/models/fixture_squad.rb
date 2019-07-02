class FixtureSquad < ApplicationRecord
  validates_presence_of :fixture_id,
                        :player_id,
                        :team_id
  belongs_to :fixture
  belongs_to :player
  belongs_to :team
end
