class FixtureSquad < ApplicationRecord
  belongs_to :fixture, optional: :true
  belongs_to :player, optional: :true
  belongs_to :team, optional: :true

  validates_presence_of :fixture_id, :player_id, :team_id

  scope :match_squad, -> (match_id:) { where(fixture_id: match_id) }

end
