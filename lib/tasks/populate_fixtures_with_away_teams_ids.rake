namespace :app do
  desc "Persist match results"
  task :add_matches_result, [:league_id] => :environment do |_, args|
    p "Migrating..."
    AllResult.league_season_matches_results(args[:league_id])[:league_season_matches].map do |match|
      Result.find_or_create_by(
      {
        fixture_id: match[:fixture_id],
        home_goals: match[:home_team][:goals_for],
        away_goals: match[:away_team][:goals_for]
      }
    )
    end
    p "Migrated!"
  end
end
