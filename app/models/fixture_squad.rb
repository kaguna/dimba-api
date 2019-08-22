class FixtureSquad < ApplicationRecord
  validates_presence_of :fixture_id,
                        :player_id,
                        :team_id
  belongs_to :fixture, optional: :true
  belongs_to :player, optional: :true
  belongs_to :team, optional: :true
end
