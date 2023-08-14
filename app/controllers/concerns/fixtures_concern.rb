module FixturesConcern
  def generate(league_id, season_id, home_away)
    generate_fixtures(league_id, season_id, home_away)
  end

  private

  def generate_fixtures(league_id, season_id, home_away)
    fixtures = []
    shuffle_matches(league_id, season_id, home_away).each do |team|
      fixtures.push(format_matches(team[0], team[1]))
    end
    fixtures
  end

  def get_teams(league_id, season_id)
    matches ||= LeaguesTeam.joins(:team).
              where(league_id: league_id, season_id: season_id).
              pluck(:team_id, :name)
  end

  def combine_teams(league_id, season_id, home_away)
    home_away == 'true' ? get_teams(league_id, season_id).permutation(2).to_a :
    get_teams(league_id, season_id).combination(2).to_a
  end

  def shuffle_matches(league_id, season_id, home_away)
    combine_teams(league_id, season_id, home_away).shuffle!
  end

  def format_matches(home_team, away_team)
    { 
      home_team: home_team, 
      away_team: away_team
    }
  end
end
