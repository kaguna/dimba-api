
# module leagueSeasonResults
#   extend ActiveSupport::Concern
#   include MatchResults

#   def league_season_matches_results(league_id, season_id)
#     Fixture.all.map do |match|
#       match_results match&.id
#     end.compact.to_json
#   end
# end
