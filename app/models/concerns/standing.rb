# frozen_string_literal: true

module Standing
  extend ActiveSupport::Concern

  class << self
    def league_season_standings(league_season_matches)
      standing ||= sort_standings(game_stats: league_season_matches)
    end

    private

    def extract_team_stat(game_stats:)
      teams ||= game_stats.map { |team| [team[:home_team], team[:away_team]] }.flatten
    end

    def calculate_team_standing(game_stats:)
      extract_team_stat(game_stats: game_stats)
        .group_by { |aggregates| aggregates[:team_id] }
        .map do |team_stats|
        formulate_standing_stats(team_stats)
      end
    end

    def sort_standings(game_stats:)
      calculate_team_standing(game_stats: game_stats)
        .sort do |a, b|
        [b[:points], b[:goal_difference], b[:goals_for], a[:team_name]] <=>
          [a[:points], a[:goal_difference], a[:goals_for], b[:team_name]]
      end
    end

    def formulate_standing_stats(team_stats)
      {
        team_id: team_stats[1][0][:team_id],
        team_name: team_stats[1][0][:team_name].titleize,
        games_played: count_games_played(team_stats),
        wins: count_wins(team_stats),
        draws: count_draws(team_stats),
        losses: count_losses(team_stats),
        goals_for: count_goals_for(team_stats),
        goals_against: count_goals_against(team_stats),
        goal_difference: count_goal_difference(team_stats),
        points: calculate_points(team_stats),
        form: form(team_stats)
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
      team_stats[1].map { |team_hash| team_hash[:goals_for] }.compact.inject(:+)
    end

    def count_goals_against(team_stats)
      team_stats[1].map { |team_hash| team_hash[:goals_against] }.compact.inject(:+)
    end

    def count_goal_difference(team_stats)
      count_goals_for(team_stats).nil? || count_goals_against(team_stats).nil? ? 0 :
      count_goals_for(team_stats) - count_goals_against(team_stats)
    end

    def calculate_points(team_stats)
      count_games_played(team_stats) == 0 ? 0 :
      team_stats[1].map { |team_hash| team_hash[:points] }.inject(:+)
    end

    def form(team_matches)
      team_matches[1].last(5).reverse!
    end
  end
end
