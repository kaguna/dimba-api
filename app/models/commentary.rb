class Commentary < ApplicationRecord
  

  belongs_to :fixture
  belongs_to :team, optional: :true
  belongs_to :event
  belongs_to :player, optional: :true

  scope :commentaries, -> (match_id) { where(fixture_id: match_id) }
  scope :goals, -> { where(event_id: 1) }
  # scope :played, -> { Fixture.includes(:commentaries) }

  # def self.match_commentaries(match_id)
  #   commentaries(match_id).to_json
  # end

  # class << self
  # def self.league_season_matches_results(league_id, season_id)
  #   {league_results: Fixture.all.map { |match| match_results match&.id }}.to_json
  # end

  # def self.full_match_results(match_id)
  #   MatchResults.match_results(match_id)
  # end
  # end
end
