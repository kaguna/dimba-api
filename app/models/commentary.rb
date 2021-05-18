class Commentary < ApplicationRecord
  

  belongs_to :fixture
  belongs_to :team, optional: :true
  belongs_to :event
  belongs_to :player, optional: :true
  belongs_to :commentary_player, class_name: "Player", foreign_key: "player_in", optional: true

  scope :commentaries, -> (match_id) { where(fixture_id: match_id).order('CAST(commentary_time as INT) desc') }
  scope :goals, -> { where(event_id: 1) }

  scope :played_match_ids , -> { Result.all.map(&:fixture_id) }

  # refactor all here
  # scope :current_season, -> {Season.current.first&.id}
  # scope :league_matches, -> (league_id) do
  #   Fixture.where(league_id: league_id, season_id: current_season)
  # end

  def self.match_commentaries(match_id)
    commentaries ||= commentaries(match_id)
  end
end
