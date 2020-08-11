class Result < ApplicationRecord
  
  belongs_to :fixture

  def self.league_season_matches_results(league_id)
    includes(:fixture).where(fixtures: {league_id: league_id})
  end

  def self.full_match_results(match_id)
    includes(:fixture).where(fixture_id: match_id)
  end

  def points(home_goals, away_goals)
    if home_goals > away_goals then 3
    elsif home_goals == away_goals then 1
    else 0
    end
  end

  def home_team
    {
      id: fixture.home_team&.id, 
      name: fixture.home_team&.name,
      goals_for: home_goals,
      goals_against: away_goals,
      points: points(home_goals, away_goals),
    }
  end

  def away_team
    {
      id: fixture.away_team&.id, 
      name: fixture.away_team&.name,
      goals_for: away_goals,
      goals_against: home_goals,
      points: points(away_goals, home_goals),
    }
  end

  def match_day
    fixture.match_day
  end
end