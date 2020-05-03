# module Match
#   class Result
#     def initialize(league_id:, season_id:)
#       @league_id = league_id
#       @season_id = season_id
#     end

#     def match_result
#       match_commentaries.map do |match|
#         match_stats match
#       end.compact.to_json
#     end

#     def match_stats(fixture)
#       commentaries = fixture.commentaries

#       # Excludes all the matches which are yet to be played.
#       return unless commentaries.present?

#       home_team = fixture.home_team
#       away_team = fixture.away_team

#       home_team_goals = match_team_goals(match_commentaries: commentaries,
#                                           team: home_team)
#       away_team_goals = match_team_goals(match_commentaries: commentaries,
#                                           team: away_team)
#       {
#         fixture_id: fixture.id,
#         home_team: team_stats(team: home_team,
#                                 goals_for: home_team_goals,
#                                 goals_against: away_team_goals),
#         away_team: team_stats(team: away_team,
#                               goals_for: away_team_goals,
#                               goals_against: home_team_goals)
#       }
#     end

#     def team_stats(team:, goals_for:, goals_against:)
#       {
#         team_id: team.id,
#         team_name: team.name,
#         goals_for: goals_for,
#         goals_against: goals_against,
#         points: calculate_match_points(goals_for: goals_for,
#                                       goals_against: goals_against)
#       }
#     end

#     private

#     def match_commentaries
#         @match_commentaries ||= Fixture.includes(:commentaries,
#                                                 :home_team, :away_team)
#                                         .where(league_id: @league_id,
#                                             season_id: @season_id)
#     end

#     def match_team_goals(fixture_commentaries:, team:)
#         match_commentaries.where(event_id: 1, team: team).pluck(:event_id).sum
#     end

#     def calculate_match_points(goals_for:, goals_against:)
#       if goals_for > goals_against then 3
#       elsif goals_for == goals_against then 1
#       else 0
#       end
#     end
#   end
# end
