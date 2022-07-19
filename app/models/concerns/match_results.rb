module MatchResults
  extend ActiveSupport::Concern

  def self.commentaries(match_id)
    commentaries = Commentary.where(fixture_id: match_id)
    commentaries.empty? ? nil : commentaries
  end

  def self.get_match_results(match_id)
    raise "Fixture not found" unless match = Fixture.find_by(id: match_id)

    home_team_goals ||= match.played? ? match.result.home_goals :
     self.count_goals(match_commentaries: self.commentaries(match_id), team: match.home_team)
    away_team_goals ||= match.played? ? match.result.away_goals :
     self.count_goals(match_commentaries: self.commentaries(match_id), team: match.away_team)
    {
      fixture_id: match.id,
      match_day: match.match_day,
      home_team: self.team_goals(team: match.home_team, other_team: match.away_team.name,
                                                  match_day: match.match_day,
                                                  goals_for: home_team_goals,
                                                  goals_against: away_team_goals),
      away_team: self.team_goals(team: match.away_team, other_team: match.home_team.name,
                                                  match_day: match.match_day,
                                                  goals_for: away_team_goals, 
                                                  goals_against: home_team_goals)
    }
  end

  def self.team_goals(team:, other_team:, match_day:, goals_for:, goals_against:)
    {
      team_id: team.id,
      team_name: team.name,
      other_team: other_team,
      match_day: match_day,
      goals_for: goals_for,
      goals_against: goals_against,
      points: self.calculate_match_points(goals_for: goals_for, goals_against: goals_against)
    }
  end

  def self.count_goals(match_commentaries:, team:)
    match_commentaries.nil? ? 0 :
      match_commentaries.where(team: team).goals.pluck(:event_id).sum
  end

  def self.calculate_match_points(goals_for:, goals_against:)
    if goals_for > goals_against then 3
    elsif goals_for == goals_against then 1
    else 0
    end
  end
end
