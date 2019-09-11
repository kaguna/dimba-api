module Standings
  class Statistics
    def initialize(league_id:, season_id:)
      @league_id = league_id
      @season_id = season_id
    end

    def league_stats
      game_stats = league_commentaries.map do |fixture|
        fixture_stats fixture
      end.compact
      {results: game_stats, standings: sort_standings(game_stats: game_stats)}
    end

    def fixture_stats(fixture)
      commentaries = fixture.commentaries

      # Excludes all the matches which are yet to be played.
      return unless commentaries.present?

      home_team = fixture.home_team
      away_team = fixture.away_team

      home_team_goals = fixture_team_goals(fixture_commentaries: commentaries,
                                          team: home_team)
      away_team_goals = fixture_team_goals(fixture_commentaries: commentaries,
                                          team: away_team)
      {
        fixture_id: fixture.id,
        home_team: team_stats(team: home_team,
                              goals_for: home_team_goals,
                              goals_against: away_team_goals),
        away_team: team_stats(team: away_team,
                              goals_for: away_team_goals,
                              goals_against: home_team_goals)
      }
    end

    def team_stats(team:, goals_for:, goals_against:)
      {
        team_id: team.id,
        team_name: team.name,
        goals_for: goals_for,
        goals_against: goals_against,
        points: calculate_fixture_points(goals_for: goals_for,
                                        goals_against: goals_against)
      }
    end

    private

    def league_commentaries
      @league_commentaries ||= Fixture.includes(:commentaries,
                                                :home_team, :away_team)
                                      .where(league_id: @league_id,
                                            season_id: @season_id)
    end

    def fixture_team_goals(fixture_commentaries:, team:)
      fixture_commentaries.where(event_id: 1, team: team).pluck(:event_id).sum
    end

    def calculate_fixture_points(goals_for:, goals_against:)
      if goals_for > goals_against then 3
      elsif goals_for == goals_against then 1
      else 0
      end
    end

    def extract_team_stat(game_stats:)
      teams ||= game_stats.map { |team| [ team[:home_team], team[:away_team] ] }.flatten
    end

    def calculate_team_standing(game_stats:)
      extract_team_stat(game_stats: game_stats)
        .group_by { |aggregates| aggregates[:team_id] }
            .map{ |team_stats| 
              formulate_standing_stats(team_stats)
            }
    end

    def sort_standings(game_stats:)
      calculate_team_standing(game_stats: game_stats)
      .sort { |a, b| 
        [b[:points], b[:goal_difference], b[:goals_for], a[:team_name]] <=> 
        [a[:points], a[:goal_difference],a[:goals_for], b[:team_name]] 
      }
    end

    def formulate_standing_stats(team_stats)
      {
        team_id: team_stats[1][0][:team_id],
        team_name: team_stats[1][0][:team_name],
        games_played: count_games_played(team_stats),
        wins: count_wins(team_stats),
        draws: count_draws(team_stats),
        losses: count_losses(team_stats),
        goals_for: count_goals_for(team_stats),
        goals_against: count_goals_against(team_stats),
        goal_difference: count_goal_difference(team_stats),
        points: calculate_points(team_stats)
      }
    end

    def count_games_played(team_stats)
      team_stats[1].length
    end

    def count_wins(team_stats)
      team_stats[1].count { |points| points[:points] == 3 }
    end

    def count_draws(team_stats)
      team_stats[1].count { |points| points[:points] == 1 }
    end

    def count_losses(team_stats)
      team_stats[1].count { |points| points[:points] == 0 }
    end

    def count_goals_for(team_stats)
      team_stats[1].map { |team_hash| team_hash[:goals_for]}.inject(:+)
    end

    def count_goals_against(team_stats)
      team_stats[1].map { |team_hash| team_hash[:goals_against]}.inject(:+)
    end

    def count_goal_difference(team_stats)
      count_goals_for(team_stats) - count_goals_against(team_stats)
    end

    def calculate_points(team_stats)
      team_stats[1].map { |team_hash| team_hash[:points]}.inject(:+)
    end

  end
end
