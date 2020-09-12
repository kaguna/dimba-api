module FixturesConcern
  def generate(league_id, season_id)
    generate_fixtures(league_id, season_id)
  end

  private

  def generate_fixtures(league_id, season_id)
    fixtures = []
    shuffle_matches(league_id, season_id).each do |team|
      fixtures.push(format_matches(team[0], team[1]))
    end
    fixtures
  end

  def get_teams(league_id, season_id)
    matches ||= LeaguesTeam.joins(:team).
              where(league_id: league_id, season_id: season_id).
              pluck(:team_id, :name)
  end

  def combine_teams(league_id, season_id)
    get_teams(league_id, season_id).combination(2).to_a
  end

  def shuffle_matches(league_id, season_id)
    combine_teams(league_id, season_id).shuffle!.shuffle
  end

  def format_matches(home_team, away_team)
    { 
      home_team: home_team, 
      away_team: away_team,
      match_day: generate_match_dates
    }
  end

  def generate_match_dates
    rand(Time.now + 2.weeks..Time.now + 5.weeks)
  end
end
