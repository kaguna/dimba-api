class Result < ApplicationRecord
  
  belongs_to :fixture

  validates_uniqueness_of :fixture_id, message: "results has already been updated!"

  after_save :mark_fixture_played

  def self.league_season_matches_results(league_id)
    includes(fixture:[:season])
    .where(fixtures: {league_id: league_id}, seasons: {current: true}).order("fixtures.match_day Desc")
    # .limit(15)
  end

  def self.team_home_results(team_id)
     # Clean up later
    Season.includes(:league, :fixtures)
    .where(fixtures: {played: true, home_team_id: team_id})
    .order("fixtures.match_day ASC")
    .group(:id, "leagues.id", "fixtures.id")
    # .limit(15)
  end

  def self.team_away_results(team_id)
    Season.includes(:league, :fixtures)
    .where(fixtures: {played: true, away_team_id: team_id})
    .order("fixtures.match_day ASC")
    .group(:id, "leagues.id", "fixtures.id")
    # .limit(15)
  end

  private

  def mark_fixture_played
    Fixture.where(id: self.fixture_id).update(played: true)
  end

  def points(home_goals, away_goals)
    if home_goals > away_goals then 3
    elsif home_goals == away_goals then 1
    else 0
    end
  end
end