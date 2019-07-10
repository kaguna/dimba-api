module Standings
  def league_table_data(league, season)
    points_per_team_per_fixture(league, season)
    total_points_per_team(league, season)
    goals_per_fixture(league, season)
  end

  def matches_played

  end

  def goals_per_fixture(league, season)
    # goals = "SELECT  fixture_id,team_id, name as team_name, sum(CASE WHEN commentaries.event_id = 1 THEN 1 ELSE 0 END) AS goals FROM
    #  fixtures right JOIN commentaries ON commentaries.fixture_id = fixtures.id 
    #  left join teams on teams.id = commentaries.team_id 
    #  WHERE fixtures.league_id = #{league} AND fixtures.season_id = #{season} GROUP BY name, team_id, fixture_id"
    # ActiveRecord::Base.connection.execute(goals)

    Fixture.includes(:commentaries, :team).
    where(league_id: league, season_id: season).
    select('commentaries.fixture_id, commentaries.team_id, teams.name as team_name, sum(CASE WHEN commentaries.event_id = 1 THEN 1 ELSE 0 END) AS goals').
    group('teams.name, commentaries.team_id, commentaries.fixture_id')
  end

  def points_per_team_per_fixture(league, season)
    points = []
    goals_per_fixture(league, season).each do |team_points|
      fixture_id = team_points['fixture_id']
      team_id = team_points['team_id']
      team_1_goals = team_points['goals']
      team_2_goals = 0

      goals_per_fixture(league, season).each do |team_2_points|
        fixture_id == team_2_points['fixture_id'] && team_id != team_2_points['team_id'] ? 
        team_2_goals = team_2_points['goals'] : 0
      end
      points.push(teams_points(team_points, point_system(team_1_goals, team_2_goals)))
    end
    points
  end

  def teams_points(team_points, points)
    {
      'fixture_id': team_points['fixture_id'],
      'team_id': team_points['team_id'],
      'team_name': team_points['team_name'],
      'goals': team_points['goals'],
      'points': points,
    }
  end

  def point_system(team_1_goals, team_2_goals)
    if team_1_goals > team_2_goals
      win = 3
    elsif team_1_goals == team_2_goals
      win = 1
    else
      win = 0
    end
  end

  def total_points_per_team(league, season)
    points_per_team_per_fixture(league, season).group_by{ 
      |team| team[:team_id]}.map do |k, v|
      { team_id: k, total_points: v.map {|h1| h1[:points]}.inject(:+) }
      end
  end
end
