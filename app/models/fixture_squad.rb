class FixtureSquad < ApplicationRecord
  belongs_to :fixture, optional: :true
  belongs_to :player, optional: :true
  belongs_to :team, optional: :true

  attribute :playing, :boolean, default: false

  validates :player_id, uniqueness: { scope: :fixture_id, message: "Player already added!" }

  validates_presence_of :fixture_id, :player_id, :team_id

  scope :starting_11, -> { where(playing: true) }
  scope :substitutes, -> { where(playing: false) }

  def self.match_squads(match_id:)
    squads ||= where(fixture_id: match_id)
    { squads: squads.map{ |squad| FixtureSquadSerializer.new(squad) } }
  end

  def self.home_team_fixture_squad(fixture_id)
    includes(fixture: [:home_team]).where(fictures: {id: fixture_id }).group(:playing, :id, "fixtures.id")
  end

  def self.away_team_fixture_squad
    self.away_team.fixture_squads.group(:playing, :id)
  end
end
