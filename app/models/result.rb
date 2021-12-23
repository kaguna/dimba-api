class Result < ApplicationRecord
  
  belongs_to :fixture

  validates_uniqueness_of :fixture_id, message: "results has already been updated!"

  # before_save :check_if_any_event
  after_save :mark_fixture_played!

  def self.league_season_matches_results(league_id)
    includes(fixture:[:season])
    .where(fixtures: {league_id: league_id}, seasons: {current: true}).order("fixtures.match_day Desc")
  end

  private

  # def check_if_any_event
  #   raise "No events in this match!" unless Commentary.exists?(fixture_id: self.fixture_id)
  # end

  def mark_fixture_played!
    Fixture.where(id: self.fixture_id).update(played: true)
  end

  def points(home_goals, away_goals)
    if home_goals > away_goals then 3
    elsif home_goals == away_goals then 1
    else 0
    end
  end
end