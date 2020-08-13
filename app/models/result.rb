class Result < ApplicationRecord
  
  belongs_to :fixture

  def self.league_season_matches_results(league_id)
    includes(:fixture).where(fixtures: {league_id: league_id})
  end

  def self.team_home_results(team_id)
    includes(:fixture).where(fixtures: {home_team_id: team_id})
  end

  def self.team_away_results(team_id)
    includes(:fixture).where(fixtures: {away_team_id: team_id})
  end

  # def points(home_goals, away_goals)
  #   if home_goals > away_goals then 3
  #   elsif home_goals == away_goals then 1
  #   else 0
  #   end
  # end

  # def home_team
  #   {
  #     id: fixture.home_team&.id, 
  #     name: fixture.home_team&.name,
  #     goals_for: home_goals || null,
  #     goals_against: away_goals || null,
  #     points: points(home_goals, away_goals) || null,
  #   }
  # end

  # def away_team
  #   {
  #     id: fixture.away_team&.id, 
  #     name: fixture.away_team&.name,
  #     goals_for: away_goals || null,
  #     goals_against: home_goals || null,
  #     points: points(away_goals, home_goals) || null,
  #   }
  # end

  # def match_day
  #   fixture.match_day
  # end
end