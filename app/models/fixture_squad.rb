class FixtureSquad < ApplicationRecord
  belongs_to :fixture, optional: :true
  belongs_to :player, optional: :true
  belongs_to :team, optional: :true

  validates_presence_of :fixture_id, :player_id, :team_id

  def self.match_squads(match_id:)
    squads ||= where(fixture_id: match_id)
    { squads: squads.map{ |squad| FixtureSquadSerializer.new(squad) } }
  end
end
