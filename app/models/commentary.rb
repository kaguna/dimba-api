class Commentary < ApplicationRecord
  SUBSTITUTION = "Substitution".freeze

  belongs_to :fixture
  belongs_to :team, optional: :true
  belongs_to :event
  belongs_to :player, optional: :true
  belongs_to :commentary_player, class_name: "Player", foreign_key: "player_in", optional: true

  scope :commentaries, -> (match_id) { where(fixture_id: match_id).order('CAST(commentary_time as INT) desc', :created_at) }
  scope :goals, -> { where(event_id: 1) }

  scope :played_match_ids , -> { Result.all.pluck(:fixture_id) }
  scope :fixture_squad , -> { FixtureSquad.where(fixture_id: self.fixture.id) }

  after_save :avail_player_in_for_events!, if: :event_substitution?

  # refactor all here
  # scope :current_season, -> {Season.current.first&.id}
  # scope :league_matches, -> (league_id) do
  #   Fixture.where(league_id: league_id, season_id: current_season)
  # end

  def self.match_commentaries(match_id)
    commentaries ||= commentaries(match_id)
  end

  private

  def event_substitution?
    self.event.name == SUBSTITUTION
  end

  def avail_player_in_for_events!
    ActiveRecord::Base.transaction do
      fixture_squad.where(player_id: self.player.id).first.update!(playing: false)
      fixture_squad.where(player_id: self.commentary_player.id).first.update!(playing: true)
    end
  end
end
