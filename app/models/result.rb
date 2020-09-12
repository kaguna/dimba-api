class Result < ApplicationRecord
  
  belongs_to :fixture

  def self.league_season_matches_results(league_id)
    includes(fixture:[:season])
    .where(fixtures: {league_id: league_id}, seasons: {current: true})
  end

  def self.team_home_results(team_id)
    includes(:fixture).where(fixtures: {home_team_id: team_id})
  end

  def self.team_away_results(team_id)
    includes(:fixture).where(fixtures: {away_team_id: team_id})
  end

  def points(home_goals, away_goals)
    if home_goals > away_goals then 3
    elsif home_goals == away_goals then 1
    else 0
    end
  end
end